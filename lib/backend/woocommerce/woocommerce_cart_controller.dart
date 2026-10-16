import 'dart:async';

import 'package:flutter/foundation.dart';

import 'cart_models.dart';
import 'woocommerce_cart_service.dart';

/// Shared in-memory cart state for future UI integration.
///
/// The application singleton survives route changes and widget rebuilds. The
/// controller intentionally does not persist the service's Cart-Token.
class WooCommerceCartController extends ChangeNotifier {
  WooCommerceCartController({WooCommerceCartService? service})
      : _service = service ?? WooCommerceCartService.instance;

  static final WooCommerceCartController instance =
      WooCommerceCartController(service: WooCommerceCartService.instance);

  final WooCommerceCartService _service;
  final Map<String, Future<void>> _inFlightMutations = {};
  Future<void> _operationQueue = Future<void>.value();
  WooCart? _cart;
  String? _errorMessage;
  bool _isLoading = false;
  int _pendingMutationCount = 0;
  bool _requiresRefresh = false;

  WooCart? get cart => _cart;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get isMutationInProgress => _pendingMutationCount > 0;
  bool get requiresRefresh => _requiresRefresh;
  bool get hasLoadedCart => _cart != null;

  /// Loads the current server cart or refreshes local state from it.
  ///
  /// Cart reads share the same operation queue as mutations so a refresh
  /// cannot race and overwrite a newer mutation response.
  Future<void> loadCart() => refreshCart();

  Future<void> refreshCart() => _enqueueOperation(() async {
        _isLoading = true;
        notifyListeners();
        try {
          _cart = await _service.getCart();
          _requiresRefresh = false;
          _errorMessage = null;
        } catch (error) {
          _errorMessage = _safeErrorMessage(error);
        } finally {
          _isLoading = false;
          notifyListeners();
        }
      });

  /// Adds the product once per product while that add is in flight. A failed
  /// add is never automatically retried; the cart is refreshed to reconcile
  /// an outcome that may be uncertain.
  Future<void> addItem({required int productId, int quantity = 1}) {
    if (productId <= 0 || quantity <= 0) {
      return _reject('A valid product and quantity are required.');
    }
    return _enqueueMutation(
      dedupeKey: 'add:$productId',
      operation: () =>
          _service.addItem(productId: productId, quantity: quantity),
    );
  }

  Future<void> updateItem({required String key, required int quantity}) {
    if (key.trim().isEmpty || quantity <= 0) {
      return _reject('A valid cart item key and quantity are required.');
    }
    return _enqueueMutation(
      dedupeKey: 'update:$key:$quantity',
      operation: () => _service.updateItem(key: key, quantity: quantity),
    );
  }

  Future<void> removeItem({required String key}) {
    if (key.trim().isEmpty) {
      return _reject('A valid cart item key is required.');
    }
    return _enqueueMutation(
      dedupeKey: 'remove:$key',
      operation: () => _service.removeItem(key: key),
    );
  }

  void clearError() {
    if (_errorMessage == null) return;
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> _enqueueMutation({
    required String dedupeKey,
    required Future<WooCart> Function() operation,
  }) {
    if (_requiresRefresh) {
      return _reject('Refresh the cart before trying again.');
    }
    final existing = _inFlightMutations[dedupeKey];
    if (existing != null) return existing;

    _pendingMutationCount++;
    notifyListeners();
    final future = _enqueueOperation(() async {
      try {
        // The server response is authoritative after each successful mutation.
        _cart = await operation();
        _requiresRefresh = false;
        _errorMessage = null;
      } catch (error) {
        await _recoverAfterMutationFailure(error);
      } finally {
        _pendingMutationCount--;
        notifyListeners();
      }
    });
    _inFlightMutations[dedupeKey] = future;
    future.whenComplete(() {
      if (identical(_inFlightMutations[dedupeKey], future)) {
        _inFlightMutations.remove(dedupeKey);
      }
    });
    return future;
  }

  Future<void> _recoverAfterMutationFailure(Object error) async {
    final mutationError = _safeErrorMessage(error);
    _requiresRefresh = true;
    _isLoading = true;
    notifyListeners();
    try {
      // A read reconciles a potentially completed mutation without replaying
      // it. If this read fails, further mutations remain blocked until refresh.
      _cart = await _service.getCart();
      _requiresRefresh = false;
      _errorMessage = mutationError;
    } catch (_) {
      _requiresRefresh = true;
      _errorMessage =
          '$mutationError The cart could not be refreshed; refresh before trying again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _reject(String message) {
    _errorMessage = message;
    notifyListeners();
    return Future<void>.value();
  }

  Future<void> _enqueueOperation(Future<void> Function() operation) {
    final result = _operationQueue.then((_) => operation());
    // A failed queued operation must not prevent later refreshes or mutations.
    _operationQueue = result.then<void>(
      (_) {},
      onError: (Object _, StackTrace __) {},
    );
    return result;
  }

  String _safeErrorMessage(Object error) => error is WooCartException
      ? error.message
      : 'The cart request failed. Please refresh and try again.';
}
