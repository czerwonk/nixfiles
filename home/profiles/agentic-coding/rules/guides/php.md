# PHP Guide

## Conventions
- PSR-12 coding style, PSR-4 autoloading
- `declare(strict_types=1);` and type declarations for parameters, return types and properties

## Checklist
1. `php-cs-fixer fix .`
2. `php -l` on changed files
3. `phpstan analyse` or `psalm` (whichever the project uses)
4. `phpunit` or `pest`
5. `composer audit`
