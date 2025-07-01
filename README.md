# FastLove - Сайт знакомств

Django веб-приложение для онлайн знакомств с современным дизайном и удобным интерфейсом.

## 🚀 Деплой

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)

**Live Demo:** [https://fastlove.onrender.com](https://fastlove.onrender.com)

## ✨ Особенности

- 💝 Современный дизайн сайта знакомств
- 📱 Адаптивная верстка для всех устройств
- 🔒 Безопасность и приватность
- ⚡ Быстрая загрузка страниц
- 🎨 Красивые анимации и переходы

## 🛠 Технологии

- **Backend:** Django 5.1.6
- **Frontend:** HTML5, CSS3, JavaScript
- **База данных:** SQLite (разработка) / PostgreSQL (продакшен)
- **Деплой:** Render.com
- **Статические файлы:** WhiteNoise

## 📋 Структура

```
fastlove/
├── 📁 fastlove/          # Django проект
├── 📁 landing/           # Основное приложение
├── 📁 templates/         # HTML шаблоны
├── 📁 static/            # CSS, JS, изображения
├── 🐳 build.sh           # Скрипт сборки
├── 📦 requirements.txt   # Python зависимости
└── ⚙️ render.yaml        # Конфигурация Render
```

## 🚀 Быстрый старт

### Локальная разработка

```bash
# Клонирование
git clone https://github.com/yourusername/fastlove.git
cd fastlove

# Виртуальное окружение
python -m venv venv
source venv/bin/activate  # Linux/Mac
# или
venv\Scripts\activate     # Windows

# Установка зависимостей
pip install -r requirements.txt

# Миграции
python manage.py migrate

# Создание суперпользователя
python manage.py createsuperuser

# Запуск сервера
python manage.py runserver
```

Сайт будет доступен по адресу: http://localhost:8000

### Деплой на Render

1. **Форкни репозиторий** на GitHub
2. **Создай аккаунт** на [Render.com](https://render.com)
3. **Подключи GitHub** репозиторий
4. **Настрой переменные окружения:**
   ```
   DEBUG=False
   SECRET_KEY=your-secret-key-here
   ```

Подробная инструкция: [RENDER_DEPLOY.md](RENDER_DEPLOY.md)

## 📸 Скриншоты

### Главная страница
Современный лендинг с призывом к действию

### Страница цен
Прозрачные тарифные планы

### Контакты
Удобная форма обратной связи

## 🔧 Администрирование

- **Админка:** `/admin/`
- **Управление контентом** через Django Admin
- **Мониторинг** через Render Dashboard

## 📄 Страницы

- **/** - Главная страница
- **/price/** - Тарифы и цены
- **/terms/** - Условия использования
- **/privacy/** - Политика конфиденциальности
- **/contacts/** - Контактная информация
- **/admin/** - Панель администратора

## 🤝 Вклад в проект

1. Форкни проект
2. Создай ветку для фичи (`git checkout -b feature/amazing-feature`)
3. Закоммить изменения (`git commit -m 'Add amazing feature'`)
4. Запуш в ветку (`git push origin feature/amazing-feature`)
5. Открой Pull Request

## 📝 Лицензия

Этот проект распространяется под лицензией MIT. Подробности в файле [LICENSE](LICENSE).

## 📞 Контакты

- **Сайт:** [znakomstvazdes.ru](https://znakomstvazdes.ru)
- **Email:** support@znakomstvazdes.ru

---

⭐ **Поставь звездочку, если проект понравился!** 