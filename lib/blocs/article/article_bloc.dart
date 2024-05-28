import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/blocs/article/article_event.dart';
import 'package:testing/blocs/article/article_state.dart';
import 'package:testing/domain/repositories/article_repository.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc() : super(ArticleInitial()) {
    on(_mapGetArticle);
  }

  _mapGetArticle(event, emit) async {
    emit(ArticleLoading());
    try {
      final data = await ArticleRepository().article();
      emit(ArticleSuccess(data));
    } catch (e) {
      emit(ArticleError(e.toString()));
    }
  }
}
