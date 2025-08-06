#!/bin/bash

# Deploy script for VDSINA
set -e

echo "=== FastLove Deploy Script for VDSINA ==="

# Проверяем, что скрипт запущен от пользователя, а не root
if [ "$EUID" -eq 0 ]; then
    echo "Не запускайте этот скрипт от root!"
    exit 1
fi

# Переменные
PROJECT_NAME="fastlove"
DOMAIN="your-domain.com"  # Замените на ваш домен
USER=$(whoami)
PROJECT_DIR="/home/$USER/$PROJECT_NAME"
VENV_DIR="/home/$USER/venv"

echo "Пользователь: $USER"
echo "Директория проекта: $PROJECT_DIR"
echo "Виртуальное окружение: $VENV_DIR"

# Обновляем систему
echo "=== Обновление системы ==="
sudo apt update && sudo apt upgrade -y

# Устанавливаем необходимые пакеты
echo "=== Установка пакетов ==="
sudo apt install -y python3 python3-pip python3-venv nginx postgresql postgresql-contrib supervisor git

# Создаем виртуальное окружение
echo "=== Создание виртуального окружения ==="
python3 -m venv $VENV_DIR
source $VENV_DIR/bin/activate

# Обновляем pip
pip install --upgrade pip

# Устанавливаем зависимости
echo "=== Установка зависимостей Python ==="
cd $PROJECT_DIR
pip install -r requirements.txt

# Настройка PostgreSQL
echo "=== Настройка PostgreSQL ==="
sudo -u postgres createdb $PROJECT_NAME 2>/dev/null || echo "База данных уже существует"
sudo -u postgres createuser $PROJECT_NAME 2>/dev/null || echo "Пользователь уже существует"
sudo -u postgres psql -c "ALTER USER $PROJECT_NAME PASSWORD '$PROJECT_NAME';" || true
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE $PROJECT_NAME TO $PROJECT_NAME;" || true

# Собираем статические файлы
echo "=== Сборка статических файлов ==="
python manage.py collectstatic --noinput

# Применяем миграции
echo "=== Применение миграций ==="
python manage.py migrate

# Создаем суперпользователя (опционально)
echo "=== Создание суперпользователя ==="
echo "Хотите создать суперпользователя? (y/n)"
read -r create_superuser
if [ "$create_superuser" = "y" ]; then
    python manage.py createsuperuser
fi

echo "=== Деплой завершен ==="
echo "Теперь:"
echo "1. Настройте переменные окружения в .env файле"
echo "2. Настройте nginx: sudo cp nginx.conf /etc/nginx/sites-available/$PROJECT_NAME"
echo "3. Активируйте сайт: sudo ln -s /etc/nginx/sites-available/$PROJECT_NAME /etc/nginx/sites-enabled/"
echo "4. Настройте systemd: sudo cp fastlove.service /etc/systemd/system/"
echo "5. Запустите сервисы: sudo systemctl enable --now fastlove nginx"