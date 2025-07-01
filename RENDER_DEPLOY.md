# Деплой на Render

## Быстрый старт

### 1. Подготовка репозитория
```bash
git add .
git commit -m "Подготовка для деплоя на Render"
git push origin main
```

### 2. Создание сервиса на Render

1. **Заходи на render.com** и регистрируйся
2. **Подключи GitHub** репозиторий
3. **Создай Web Service:**
   - **Name:** `fastlove`
   - **Environment:** `Python 3`
   - **Build Command:** `./build.sh`
   - **Start Command:** `gunicorn fastlove.wsgi:application`
   - **Plan:** `Free`

### 3. Настройка переменных окружения

В разделе **Environment** добавь:

```
DEBUG=False
SECRET_KEY=your-super-secret-key-here
WEB_CONCURRENCY=4
```

### 4. Создание базы данных (опционально)

Для продакшена создай **PostgreSQL** базу:
1. **New** → **PostgreSQL**
2. **Name:** `fastlove-db`
3. **Plan:** `Free`
4. Скопируй **Internal Database URL**
5. Добавь в переменные окружения:
   ```
   DATABASE_URL=скопированный-url
   ```

## Структура проекта

```
fastlove/
├── build.sh              # Скрипт сборки для Render
├── render.yaml           # Конфигурация сервиса (опционально)
├── requirements.txt      # Python зависимости
├── manage.py            # Django manage
├── fastlove/
│   ├── settings.py      # Настройки (обновлены для Render)
│   ├── urls.py          # URL конфигурация
│   └── wsgi.py          # WSGI приложение
├── landing/             # Django приложение
├── templates/           # HTML шаблоны
└── static/             # Статические файлы
```

## Команды для разработки

### Локальный запуск
```bash
# Установка зависимостей
pip install -r requirements.txt

# Миграции
python manage.py migrate

# Создание суперпользователя
python manage.py createsuperuser

# Запуск сервера
python manage.py runserver
```

### Сбор статики
```bash
python manage.py collectstatic
```

## Важные особенности Render

- ✅ **Автоматический деплой** при push в main
- ✅ **Бесплатный план** с ограничениями
- ✅ **HTTPS** из коробки
- ✅ **PostgreSQL** в продакшене
- ✅ **WhiteNoise** для статических файлов

## После деплоя

1. **Сайт будет доступен** по адресу: `https://fastlove.onrender.com`
2. **Админка:** `https://fastlove.onrender.com/admin/`
3. **Создай суперпользователя** через Render Shell:
   ```bash
   python manage.py createsuperuser
   ```

## Обновление домена

Чтобы использовать `znakomstvazdes.ru`:
1. **В Render:** Settings → Custom Domains
2. **Добавь:** `znakomstvazdes.ru`
3. **В DNS:** настрой CNAME на Render URL

## Мониторинг

- **Логи:** Render Dashboard → Logs
- **Метрики:** Render Dashboard → Metrics  
- **Статус:** Render Dashboard → Events

## Готово! 🚀

Render автоматически:
- Установит зависимости
- Соберёт статические файлы  
- Применит миграции
- Запустит приложение

**URL:** https://fastlove.onrender.com 