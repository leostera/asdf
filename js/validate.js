import {
  compose,
  over,
  set,
  view,
} from 'ramda';

const stringify = value => {
  if(!value) return ""
  if(value.inspect && typeof value.inspect == 'function') return value.inspect()
  if(Array.isArray(value)) return `[${value.map(stringify).join(', ')}]`
  return JSON.stringify(value)
}

const inspect = type => value => () => `${type}(${stringify(value)})`

const Type = type => value => Object.freeze({
  type,
  value,
  inspect: inspect(type)(value),
});

const unwrap = ({value}) => value
const is = name => ({type}) => type === name

const Right = Type('Right')
const Left = Type('Left')
const isLeft = is('Left')

// rule : (a -> Bool) -> String -> Lens -> a -> Either ErrorString ()
const runRule = predicate => error => viewer => input =>
  predicate(view(viewer)(input)) === true ? Right(input) : Left(error);

// Run a set of validation rules over an object and collect them through
// the given error lens.
//
// Lens : a Ramda lens
// Rule : [ Lens, Message, Predicate ]
//
// validator : Lens -> [Rule] -> a -> a
const validate = errorLens => rules => input =>
  rules
    .reduce((output, rule) => {
      const unwrappedOutput = unwrap(output);
      const [lens, message, predicate] = rule;
      const result = runRule(predicate)(message)(lens)(unwrappedOutput);
      if (isLeft(result)) {
        const fullErrorLens = compose(errorLens, lens);
        const updateErrors = oldErrors => {
          if (Array.isArray(oldErrors)) return [...oldErrors, message];
          return [message];
        };
        return Left(over(fullErrorLens)(updateErrors)(unwrappedOutput));
      }
      return output;
    }, Right(set(errorLens, {}, input)));


// sample
      const errorLens = lensProp('__errors');
      const testPredicate = () => false;
      const testRules = [
        [lensProp('arbitrary-key-1'), 'arbitrary-message-1', testPredicate],
        [lensProp('arbitrary-key-1'), 'arbitrary-message-4', testPredicate],
        [lensProp('arbitrary-key-2'), 'arbitrary-message-2', () => true],
        [lensProp('arbitrary-key-3'), 'arbitrary-message-3', testPredicate],
      ];
      const testInput = {
        'arbitrary-key-1': 'arbitrary-value-1',
        'arbitrary-key-2': 'arbitrary-value-2',
        'arbitrary-key-3': 'arbitrary-value-3',
      };
      const validator = validate(testErrorLens)(testRules);

      const result = validator(testInput);

      const expectedOutput = {
        ...testInput,
        'arbitrary-errors-key': {
          'arbitrary-key-1': ['arbitrary-message-1', 'arbitrary-message-4'],
          'arbitrary-key-3': ['arbitrary-message-3'],
        },
      };
