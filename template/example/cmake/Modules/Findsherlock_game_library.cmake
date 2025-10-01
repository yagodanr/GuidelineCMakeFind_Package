FUNCTION (explore_dir curDir)
    # Створює змінну FoD, яка є списком відносних шляхів всього, що знаходиться
    # за шляхом <currentDir> відносно нього.
    # Наприклад відносним шляхами файлу якийсь/шлях/файл.txt та папки
    # якийсь/шлях/docs відносно якийсь/шлях/
    # будуть їхні ж назви, а саме: файл.txt та docs
    FILE (GLOB FoD RELATIVE "${curDir}/" "${curDir}/*")

    SET (Dirs  "")
    SET (Files "")

    FOREACH (elm ${FoD})
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

# Функція: check_files()
# =======================
# Приймає:  files - список файлів
# Виконує:  проходиться по списку і превіряє чи в ньому нема цілі пошуку
#           <MOST_WANTED>
# Повертає: список файлів даного шляху змінною <Files>
#           список директорій даного шляху змінною <Dirs>
# ========================
FUNCTION (check_files files)
    # Ітеруємоcь по файлах, що були передані функції
    FOREACH (elm ${files})
        # STRING () - дуже корисна функція
        # Прапорець FIND просить cmake перевірити,
        # чи є у стрічці  elm (назва файлу)
        # підстрічка MOST_WANTED.
        # Якщо так, то створює змінну is_found та
        # передає їй індекс початку підстрічки
        # Якщо ж ні - те саме, тільки передається -1
        STRING (FIND "${elm}" "${MOST_WANTED}" is_found)
        # Перевіряємо чи ціль знайдено
        IF (is_found GREATER -1)
            # Повідомляємо про знахіду
            MESSAGE (">>>\t FOUND: ${elm}")
            # Виходимо з циклу
            BREAK ()
        ENDIF ()
    ENDFOREACH ()
ENDFUNCTION ()


# Загальна назва бібліотеки без префікса та розширення
SET (MY_LIB "sherlock_game_library")

# Назва бібліотеки із врахуванням особливостей системи.
# Заради лаконічності код дещо спрощений.
IF (WIN32 OR CYGWIN OR MSYS)
    SET (MY_LIBRARIES "${CMAKE_SHARED_LIBRARY_PREFIX}${MY_LIB}.dll")
ELSEIF (APPLE)
    SET (MY_LIBRARIES "${CMAKE_SHARED_LIBRARY_PREFIX}${MY_LIB}.dylib")
ELSEIF (UNIX)
    SET (MY_LIBRARIES "${CMAKE_SHARED_LIBRARY_PREFIX}${MY_LIB}.so")
ELSE()
    MESSAGE (FATAL_ERROR "NOT SUPORTED SYSTEM")
ENDIF()
# CMAKE_SHARED_LIBRARY_PREFIX - префікс бібліотеки, наприклад, lib
# FATAL_ERROR - збуджує помилку

# Необхідні хідери
SET (MY_INCLUDES  inc_e_holmes.h;
                  inc_g_lestrade.h;
                  inc_j_moriarty.h;
                  inc_j_watson.h;
                  inc_m_holmes.h;
                  inc_m_hooper.h;
                  inc_m_hudson.h;
                  inc_m_watson.h;
                  inc_s_holmes.h)

# Ціль пошуку
# На деякий час забудемо про пошук хідерів і заради простоти сконцентруємось
# на бібліотеці
SET (MOST_WANTED ${MY_LIBRARIES})

# Ми знаємо що в цій директорії знаходиться бібліотека
explore_dir("${CMAKE_SOURCE_DIR}/../search_dir/lib")
# Передаємо функції файли, знайдені explore_dir()
check_files ("${Files}")
