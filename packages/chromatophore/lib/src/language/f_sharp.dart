import '../category.dart';
import '../language.dart';
import 'patterns.dart';

Language makeFSharpLanguage() {
  var language = Language();

  // TODO: Other number formats.
  language.regExp(r'[0-9]+(u?y|u?s|u?l|u?n|U?L|uL|u)?', Category.number);

  language.regExp(r'[{}[\].,;]', Category.punctuation);
  // TODO: "()" should probably be punctuation, but old lexer has them as
  // operators.
  language.regExp(r'[()!*/&%~+=<>|-]', Category.operator);

  // A bare "_" is a pattern.
  language.regExp(r'\b_\b', Category.operator);

  language.keywords(
      Category.keyword,
      'abstract and as assert base begin class default delegate do done '
      'downcast downto elif else end exception extern false finally for fun '
      'function global if in inherit inline interface internal lazy let match '
      'member module mutable namespace new null of open or override private '
      'public rec return sig static struct then to true try type upcast use '
      'val void when while with yield');

  // Future reserved.
  language.keywords(
      Category.keyword,
      'atomic break checked component const constraint constructor continue '
      'eager fixed fori functor include measure method mixin object parallel '
      'params process protected pure recursive sealed tailcall trait virtual '
      'volatile');

  language.regExp(identifier, Category.identifier);

  language.regExp(r'"', Category.string).push('string');

  language.ruleSet('string', () {
    language.regExp('"', Category.string).pop();
    language.regExp(r'\\.', Category.stringEscape);
    language.regExp('.', Category.string);
  });

  return language;
}
