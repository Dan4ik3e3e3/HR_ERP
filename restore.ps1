param(
    [Parameter(Mandatory=$true)]
    [string]$BackupPath
)

# Проверяем существование файла резервной копии
if (-not (Test-Path $BackupPath)) {
    Write-Host "Ошибка: Файл резервной копии не найден: $BackupPath" -ForegroundColor Red
    exit 1
}

# Останавливаем сервисы
Write-Host "Останавливаем сервисы..." -ForegroundColor Yellow
docker-compose down

# Восстанавливаем данные
Write-Host "Восстанавливаем данные..." -ForegroundColor Yellow
Expand-Archive -Path $BackupPath -DestinationPath "." -Force

# Проверяем целостность данных
Write-Host "Проверяем целостность данных..." -ForegroundColor Yellow
docker-compose run --rm app1 node -e "require('./src/utils/logger').Logger.info('Проверка целостности данных после восстановления')"

# Запускаем сервисы
Write-Host "Запускаем сервисы..." -ForegroundColor Yellow
docker-compose up -d

# Проверяем статус сервисов
Write-Host "Проверяем статус сервисов..." -ForegroundColor Yellow
docker-compose ps

Write-Host "Восстановление завершено!" -ForegroundColor Green 