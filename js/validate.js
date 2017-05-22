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

const notEmpty = ['validation.errors.empty', compose(not, empty)];
const validEmail = ['validation.errors.invalidEmail', validEmailPredicate];

const rules = [
  [lensPath(['profile', 'name']), ...notEmpty],
  [lensPath(['profile', 'email']), ...notEmpty],
  [lensPath(['profile', 'email']), ...validEmail],
];

const state = {
  profile: {
    name: '',
    email: '',
  },
};

const runValidation = validate(errorLens)(rules);

const result = runValidation(state);

/*

state : {
  profile: {
    name: '',
    email: '',
  },
  __errors: {
    profile: {
      name: ['validation.errors.empty'],
      email: ['validation.errors.empty', 'validation.errors.invalidEmail'],
    },
  },
}

*/
