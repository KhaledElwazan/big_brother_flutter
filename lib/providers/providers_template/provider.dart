abstract class Provider<ModelType> {
  int size();

  bool contains(ModelType modelType);

  // Future<void> update(ModelType modelType);
  //
  // Future<void> add(ModelType modelType);
  //
  // Future<void> delete(ModelType modelType);

  initListeners();

  onChange(ModelType modelType);

  onAdd(ModelType modelType);

  onDelete(ModelType modelType);
}
