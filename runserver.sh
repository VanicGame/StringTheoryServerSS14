#!/bin/bash

# Переменная для хранения текущей версии
CURRENT_HASH=$(git rev-parse HEAD)

# Обновление репозитория
git pull
git submodule update --init --recursive

# Проверка текущей версии с последней версией
NEW_HASH=$(git rev-parse HEAD)

# Если хеши отличаются, пересобираем сервер
if [ "$CURRENT_HASH" != "$NEW_HASH" ]; then
    echo "Найдены обновления, пересборка сервера..."
    dotnet build -c release
else
    echo "Обновлений нет, запуск сервера..."
fi

# Запуск сервера
dotnet run --project Content.Server --configuration Release
