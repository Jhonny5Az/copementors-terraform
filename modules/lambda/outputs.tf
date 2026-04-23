output "api_url" {
  description = "API Gateway URL"
  value       = aws_apigatewayv2_stage.default.invoke_url
}

output "lambda_function_name" {
  value = aws_lambda_function.api.function_name
}