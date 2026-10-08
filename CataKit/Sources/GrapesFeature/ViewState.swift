public enum ViewState<T> {
  case loading
  case loaded(T)
  case empty
  case failed(Error)
}
