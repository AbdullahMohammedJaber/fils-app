enum ErrorType {
  noInternetConnection,
  timeOut,
  serverError,
  unAuthorized,
  badRequest,
  notFound,
  notSuccess,
  tooManyRequests,
  parsingError,
  unknown,
}

enum RequestType { get, post, put, patch, delete }

enum UserType { seller, customer }

enum ClassType { haraj , auction , store }

enum PaymentType { wallet , auction , pakage , cart }
