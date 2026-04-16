resource "aws_iam_role" "ts_lambda_role" {
  name               = "ts_lambda-role"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_lambda_function" "ts_lambda" {
  filename      = "src/lambda_function_${var.lambdasVersion}.zip"
  function_name = "ts_lambda"
  role          = aws_iam_role.ts_lambda_role.arn
  handler       = "index.handler"
  runtime       = "nodejs20.x"
  memory_size   = 1024
  timeout       = 300
}