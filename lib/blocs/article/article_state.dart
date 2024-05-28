import 'package:testing/domain/models/article_model.dart';

abstract class ArticleState {}

class ArticleInitial extends ArticleState {}

class ArticleLoading extends ArticleState {}

class ArticleSuccess extends ArticleState {
  final ArticleModel articleModel;

  ArticleSuccess(this.articleModel);
}

class ArticleError extends ArticleState {
  final String error;

  ArticleError(this.error);
}
