# PHP Style Guide

## Code Formatting
- **Always run `php-cs-fixer` after modifying any PHP files**
- Use `php-cs-fixer fix .` to format all PHP files in the current directory
- Use `php-cs-fixer fix --dry-run --diff .` to preview changes before applying
- Configure rules in `.php-cs-fixer.php` or `.php_cs.dist` file
- Follow PSR-12 coding standards by default

## PHP Standards
- Follow PSR-1 (Basic Coding Standard) and PSR-12 (Extended Coding Style)
- Use PSR-4 autoloading for namespaces and classes
- Follow PSR-3 for logging interfaces when applicable
- Use proper PHP opening tags `<?php` (never short tags `<?`)

## Naming Conventions
- Use PascalCase for class names
- Use camelCase for method and property names
- Use snake_case for function names (procedural code)
- Use SCREAMING_SNAKE_CASE for constants
- Use meaningful and descriptive names

## Code Structure
- Keep methods small and focused on a single responsibility
- Use proper namespace declarations
- Use type declarations for parameters and return types
- Prefer composition over inheritance
- Use dependency injection for better testability

## Error Handling
- Use exceptions for error handling, not error codes
- Create custom exception classes when appropriate
- Use try/catch blocks properly
- Validate input parameters and throw meaningful exceptions
- Use proper logging for debugging and monitoring

## Modern PHP Features
- Use strict typing: `declare(strict_types=1);`
- Use nullable types `?string` and union types `string|int` (PHP 8+)
- Use property promotion in constructors (PHP 8+)
- Use match expressions over switch when appropriate (PHP 8+)
- Use named arguments for better readability (PHP 8+)

## Database and Security
- Use prepared statements for database queries
- Validate and sanitize all user input
- Use proper password hashing with `password_hash()` and `password_verify()`
- Implement proper CSRF protection
- Use HTTPS for sensitive data transmission

## Dependencies
- Use Composer for dependency management
- Keep `composer.lock` file in version control
- Use semantic versioning for package constraints
- Regularly update dependencies for security patches
- Use `composer audit` to check for vulnerabilities

## Testing
- Write unit tests using PHPUnit or Pest
- Use descriptive test method names
- Test file naming: `*Test.php` or `*_test.php`
- Use data providers for testing multiple scenarios
- Mock external dependencies in tests

## Comments and Documentation
- Use `//` for single-line comments
- Use `/* */` for multi-line comments
- Use PHPDoc `/** */` for class and method documentation
- Document all public methods, classes, and interfaces
- Include `@param`, `@return`, and `@throws` annotations

## Code Quality Tools
- Use PHPStan or Psalm for static analysis
- Use PHP CodeSniffer for additional style checking
- Use PHPMD (PHP Mess Detector) for code quality metrics
- Address all warnings and errors from these tools

## Configuration
- Use environment variables for configuration
- Keep sensitive data out of version control
- Use `.env` files for local development
- Implement proper configuration validation
- Use configuration caching in production

## Post-Modification Checklist
1. Run `php-cs-fixer fix .` to format code
2. Run `phpstan analyse` or `psalm` for static analysis
3. Run `phpunit` or `pest` to execute tests
4. Run `composer audit` to check for security issues
5. Check `php -l` for syntax errors
6. Commit changes following git discipline rules
