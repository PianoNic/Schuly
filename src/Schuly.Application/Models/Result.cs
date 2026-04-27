namespace Schuly.Application.Models
{
    public class Result
    {
        private Result(bool isSuccess, string? error) { IsSuccess = isSuccess; Error = error; }

        public bool IsSuccess { get; }
        public bool IsFailure => !IsSuccess;
        public string? Error { get; }

        public static Result Success() => new(true, null);
        public static Result Failure(string error) => new(false, error);
        public static Result<T> Success<T>(T value) => Result<T>.Success(value);
        public static Result<T> Failure<T>(string error) => Result<T>.Failure(error);
    }

    public class Result<T>
    {
        private Result(bool isSuccess, T? value, string? error) { IsSuccess = isSuccess; Value = value; Error = error; }

        public bool IsSuccess { get; }
        public bool IsFailure => !IsSuccess;
        public T? Value { get; }
        public string? Error { get; }

        public static Result<T> Success(T value) => new(true, value, null);
        public static Result<T> Failure(string error) => new(false, default, error);
    }
}
