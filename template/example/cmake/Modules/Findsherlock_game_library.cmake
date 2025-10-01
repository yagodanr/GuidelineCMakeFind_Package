# Функція: explore_dir()
# ======================
# Приймає:  currentDir - (абсолютний) шлях
# Виконує:  проходиться по вказаному шляху і знаходить всі файли та директорії,
#           що там знаходяться
# Повертає: список файлів даного шляху змінною <Files>
#           список директорій даного шляху змінною <Dirs>
# =======================
FUNCTION (explore_dir curDir)
    # Створює змінну FoD, яка є списком відносних шляхів всього, що знаходиться
    # за шляхом <currentDir> відносно нього.
    # Наприклад відносним шляхами файлу якийсь/шлях/файл.txt та папки
    # якийсь/шлях/docs відносно якийсь/шлях/
    # будуть їхні ж назви, а саме: файл.txt та docs
    FILE (GLOB FoD RELATIVE "${curDir}/" "${curDir}/*")

    # Створює порожні змінні (списки директорій та файлів)
    SET (Dirs  "")
    SET (Files "")

    # Створює цикл, що проходиться по списку файлів і директорій
    FOREACH (elm ${FoD})
        # Перевіряє чи є даний шлях шляхом файла чи директорії
        IF (IS_DIRECTORY "${curDir}/${elm}")
            LIST (APPEND Dirs ${elm})
        ELSE ()
            LIST (APPEND Files ${elm})
        ENDIF ()
    ENDFOREACH ()

    # Копіює змінні у область, з якої функція була викликана
    SET (Dirs ${Dirs}   PARENT_SCOPE)
    SET (Files ${Files} PARENT_SCOPE)
ENDFUNCTION ()

explore_dir("${CMAKE_SOURCE_DIR}/../search_dir")
# Виводить знайдені директорії і файли
MESSAGE (">>> FOUND:")
MESSAGE (">>> \t1) Files: ${Files}")
MESSAGE (">>> \t2) Dirs:  ${Dirs}")