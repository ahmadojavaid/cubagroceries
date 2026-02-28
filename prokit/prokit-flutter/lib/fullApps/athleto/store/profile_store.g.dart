// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileStore on _ProfileStore, Store {
  late final _$selectedImageAtom =
      Atom(name: '_ProfileStore.selectedImage', context: context);

  @override
  File? get selectedImage {
    _$selectedImageAtom.reportRead();
    return super.selectedImage;
  }

  @override
  set selectedImage(File? value) {
    _$selectedImageAtom.reportWrite(value, super.selectedImage, () {
      super.selectedImage = value;
    });
  }

  late final _$pickImageAsyncAction =
      AsyncAction('_ProfileStore.pickImage', context: context);

  @override
  Future<void> pickImage() {
    return _$pickImageAsyncAction.run(() => super.pickImage());
  }

  @override
  String toString() {
    return '''
selectedImage: ${selectedImage}
    ''';
  }
}
