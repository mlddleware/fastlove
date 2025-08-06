# Развертывание FastLove на VDSINA

## Подготовка сервера

### 1. Подключение к серверу
```bash
ssh root@your-server-ip
```

### 2. Создание пользователя для приложения
```bash
# Создаем пользователя
adduser fastlove

# Добавляем в группу sudo
usermod -aG sudo fastlove

# Переключаемся на пользователя
su - fastlove
```

### 3. Настройка SSH ключей (рекомендуется)
```bash
# На локальной машине
ssh-copy-id fastlove@your-server-ip

# Или настройте вручную через ~/.ssh/authorized_keys
```

## Развертывание приложения

### 1. Клонирование проекта
```bash
cd /home/fastlove
git clone https://github.com/your-username/fastlove.git
cd fastlove
```

### 2. Настройка переменных окружения
```bash
# Копируем шаблон
cp .env.example .env

# Редактируем файл
nano .env
```

**Важно:** Измените следующие значения:
- `SECRET_KEY` - сгенерируйте новый секретный ключ
- `your-domain.com` - замените на ваш домен
- Пароли и другие чувствительные данные

### 3. Автоматическое развертывание
```bash
# Делаем скрипт исполняемым
chmod +x deploy.sh

# Запускаем развертывание
./deploy.sh
```

### 4. Настройка nginx
```bash
# Копируем конфигурацию
sudo cp nginx.conf /etc/nginx/sites-available/fastlove

# Редактируем домен
sudo nano /etc/nginx/sites-available/fastlove
# Замените your-domain.com на ваш реальный домен

# Активируем сайт
sudo ln -s /etc/nginx/sites-available/fastlove /etc/nginx/sites-enabled/

# Удаляем дефолтный сайт (опционально)
sudo rm /etc/nginx/sites-enabled/default

# Проверяем конфигурацию
sudo nginx -t

# Перезагружаем nginx
sudo systemctl reload nginx
```

### 5. Настройка systemd сервиса
```bash
# Копируем сервис
sudo cp fastlove.service /etc/systemd/system/

# Перезагружаем systemd
sudo systemctl daemon-reload

# Включаем автозапуск
sudo systemctl enable fastlove

# Запускаем сервис
sudo systemctl start fastlove

# Проверяем статус
sudo systemctl status fastlove
```

## Настройка SSL сертификата

### Установка Certbot
```bash
sudo apt install snapd
sudo snap install core; sudo snap refresh core
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
```

### Получение SSL сертификата
```bash
# Автоматическая настройка nginx
sudo certbot --nginx -d your-domain.com -d www.your-domain.com

# Или только получение сертификата
sudo certbot certonly --nginx -d your-domain.com -d www.your-domain.com
```

### Автоматическое обновление сертификата
```bash
# Тест обновления
sudo certbot renew --dry-run

# Cron задача уже настроена автоматически
```

## Управление приложением

### Логи
```bash
# Логи Django приложения
sudo journalctl -u fastlove -f

# Логи nginx
sudo tail -f /var/log/nginx/fastlove_access.log
sudo tail -f /var/log/nginx/fastlove_error.log
```

### Перезапуск сервисов
```bash
# Перезапуск Django
sudo systemctl restart fastlove

# Перезапуск nginx
sudo systemctl restart nginx

# Перезагрузка конфигурации nginx
sudo systemctl reload nginx
```

### Обновление приложения
```bash
cd /home/fastlove/fastlove

# Получаем обновления
git pull origin main

# Активируем виртуальное окружение
source /home/fastlove/venv/bin/activate

# Устанавливаем зависимости
pip install -r requirements.txt

# Применяем миграции
python manage.py migrate

# Собираем статику
python manage.py collectstatic --noinput

# Перезапускаем сервис
sudo systemctl restart fastlove
```

## Мониторинг и безопасность

### Настройка firewall
```bash
# Включаем ufw
sudo ufw enable

# Разрешаем SSH, HTTP, HTTPS
sudo ufw allow ssh
sudo ufw allow 80
sudo ufw allow 443

# Проверяем статус
sudo ufw status
```

### Backup базы данных
```bash
# Создание backup
pg_dump fastlove > backup_$(date +%Y%m%d_%H%M%S).sql

# Восстановление из backup
psql fastlove < backup_file.sql
```

### Мониторинг ресурсов
```bash
# Использование ресурсов
htop

# Дисковое пространство
df -h

# Статус сервисов
sudo systemctl status fastlove nginx postgresql
```

## Устранение проблем

### Частые проблемы

1. **502 Bad Gateway**
   ```bash
   # Проверьте статус Django приложения
   sudo systemctl status fastlove
   
   # Проверьте логи
   sudo journalctl -u fastlove -f
   ```

2. **Статические файлы не загружаются**
   ```bash
   # Пересоберите статику
   cd /home/fastlove/fastlove
   source /home/fastlove/venv/bin/activate
   python manage.py collectstatic --noinput
   ```

3. **Ошибки базы данных**
   ```bash
   # Проверьте подключение к PostgreSQL
   sudo systemctl status postgresql
   
   # Проверьте настройки в .env файле
   ```

4. **Проблемы с правами доступа**
   ```bash
   # Исправьте права на файлы проекта
   sudo chown -R fastlove:fastlove /home/fastlove/fastlove
   chmod -R 755 /home/fastlove/fastlove
   ```

## Полезные команды

```bash
# Просмотр активных подключений
sudo netstat -tulpn | grep :80
sudo netstat -tulpn | grep :443
sudo netstat -tulpn | grep :8000

# Проверка конфигурации nginx
sudo nginx -t

# Проверка Django настроек
cd /home/fastlove/fastlove
source /home/fastlove/venv/bin/activate
python manage.py check --deploy
```