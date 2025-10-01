CMAKE_MINIMUM_REQUIRED (VERSION 3.16)
SET (PRJ_NAME "sherlock_game")         # Назва проекту
SET (MY_LIB "${PRJ_NAME}_library")     # Назва нашої бібліотеки
PROJECT (${PRJ_NAME} LANGUAGES C)

# Додаємо до списку шляхів cmake шлях до нашого пошукового модуля
LIST (APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/Modules")
# Викликаємо пошуковий модуль
FIND_PACKAGE (${MY_LIB})