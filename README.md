<h1 align="center">
MetrostroiExtensionsLib - простой способ написать инжект!
</h1>
MetrostroiExtensionsLib добавляет библиотеку для инжекта в поезда аддона Metrostroi.
Многие вещи, о которых забывают создатели инжектов MetrostroiExtensionsLib учитывает за вас - сохраните себе нервы!

# Оглавление
- [Оглавление](#оглавление)
- [Основные термины](#основные-термины)
- [Быстрое начало](#быстрое-начало)
  - [Создание нового рецепта](#создание-нового-рецепта)
    - [Начало](#начало)
    - [Создание аддона](#создание-аддона)
- [Основные практики при создании рецептов](#основные-практики-при-создании-рецептов)
- [API](#api)
  - [Задание рецептов](#задание-рецептов)
    - [Выбор энтити для инжекта](#выбор-энтити-для-инжекта)
    - [Логика загрузки](#логика-загрузки)
    - [Инициализация рецепта](#инициализация-рецепта)
  - [Отключение определенного рецепта](#отключение-определенного-рецепта)
  - [Глобальные переменные, определенные рецептами. (Recipe Specific переменные)](#глобальные-переменные-определенные-рецептами-recipe-specific-переменные)
  - [Методы](#методы)
    - [Работа с ClientProps](#работа-с-clientprops)
      - [Описание таблицы ClientProps](#описание-таблицы-clientprops)
      - [Замена модели через modelcallback - MEL.UpdateModelCallback](#замена-модели-через-modelcallback---melupdatemodelcallback)
      - [Изменение созданного клиентпропа - MEL.UpdateCallback](#изменение-созданного-клиентпропа---melupdatecallback)
      - [Создание нового клиентпропа - MEL.NewClientProp](#создание-нового-клиентпропа---melnewclientprop)
    - [Инжект в существующие функции](#инжект-в-существующие-функции)
      - [Инжект в клиентскую функцию - MEL.InjectIntoClientFunction](#инжект-в-клиентскую-функцию---melinjectintoclientfunction)
      - [Инжект в серверную функцию - MEL.InjectIntoServerFunction](#инжект-в-серверную-функцию---melinjectintoserverfunction)
    - [Работа со спавнером](#работа-со-спавнером)
      - [Авторандом](#авторандом)
      - [Автоперезагрузка клиентпропов](#автоперезагрузка-клиентпропов)
      - [Описание таблицы Spawner](#описание-таблицы-spawner)
      - [Добавить новое поле в спавнер - MEL.AddSpawnerField](#добавить-новое-поле-в-спавнер---meladdspawnerfield)
      - [Пометить клиентпроп для автоперезагрузки - MEL.MarkClientPropForReload](#пометить-клиентпроп-для-автоперезагрузки---melmarkclientpropforreload)
    - [Работа с buttonmap](#работа-с-buttonmap)
      - [Описание таблицы ButtonMap](#описание-таблицы-buttonmap)
      - [Переместить существующую баттнмапу - MEL.MoveButtonMap](#переместить-существующую-баттнмапу---melmovebuttonmap)
      - [Создать новую баттнмапу - MEL.NewButtonMap](#создать-новую-баттнмапу---melnewbuttonmap)
- [Полезные инструкции](#полезные-инструкции)
  - [Автоматический metrostroi\_ext\_reload при сохранении файла](#автоматический-metrostroi_ext_reload-при-сохранении-файла)

# Основные термины
* **Инжект** - изменение существующего состава, путем "вставки" нового контента уже после его создания
* **Рецепт** - основная единица, с которой вы будете работать в MetrostroiExtensionsLib. Определяет то, как изменить состав
* **ClientProp** - клиентская модель
* **ButtonMap** - специальная карта, определяющая кнопки

# Быстрое начало
Давайте попробуем сделать максимально простой рецепт - добавить новую кнопку на 
пульт, которая будет печатать сообщение в консоль

## Создание нового рецепта
### Начало
Для создания рецепта нам необходимо создать новый аддон. Рекомендуем поднять свой выделенный сервер (srcds), с установленным Metrostroi, MetrostroiExtensionsLib и Turbostroi.
### Создание аддона
Если вы создали выделенный сервер, то аддон необходимо создавать на нем - Garry's Mod автоматически скачает наши рецепты к вам на клиент
Давайте перейдем в папку с аддонами: `<что-то до этого>\steamapps\common\GarrysMod\garrysmod\addons` (в случае с выделенным сервером - `<что-то до этого>\garrysmod\addons`)


*продолжение quickstart guide будем писать после устаканевшегося API ;)*

# Основные практики при создании рецептов
1. Называй рецепты понятно
2. Помни - твой код читают другие.
Пожалуйста, разрабатывайте рецепты так, чтобы их было приятно читать.
Конечно, не обязательно каждую строчку покрывать комментариями, но если твой рецепт делает несколько вещей - раздели и подпиши, за что каждая часть отвечает. Не обфусцируй код - кому надо, все равно прочитают. 
3. Закладывай возможность кастомизации.
Возможно, кто-то захочет расширить твой рецепт. Посмотри на стандартные рецепты - в них всегда можно добавить что-либо новое через [`Recipe Specific` переменные](#глобальные-переменные-определенные-рецептами-recipe-specific-переменные)
4. Задавай поле Description. Это поле невероятно помогает владельцам серверов и простым игрокам понять, за что каждый рецепт отвечает. 
5. Списка для спавнера лучше, чем галочки. Одна из целей Metrostroi Extensions - сделать составы рандомный спавн - максимально идеальным. Галочки не дают рандому работать правильно и отбирают у других разработчиков возможность добавлять свои новые элементы. 

# API
## Задание рецептов
### Выбор энтити для инжекта
Рецепты находятся по пути `lua/recipies/<имя вашего аддона>/<recipe_name>.lua`

По образу и подобию систем в Metrostroi, первой строчкой в файле рецепта необходимо определить рецепт: `MEL.DefineRecipe("<имя_рецепта>", "<train_type>")`

Возможные значения для `train_type`:

* Имя энтити - `gmod_subway_81-717_mvm`
* Имя типа - `717` (применится на все два энтити поезда 717 - СПБ и МСК)
* На все зарегистрированные в Metrostroi типы поездов - `all`
* Поиск по имени энтити - `mvm` выберет все энтити, где есть mvm в названии
* Таблица с именами энтити - `{"gmod_subway_81-720", "gmod_subway_81-722"}` выберет две энтити

Списов возможных типов:
* `717` - применяется только на две энтити - 717_mvm и 717_lvz. Промежутки и кастомные вагоны не учитываются
* `717_714` - применяется только на четыре энтити - 717_mvm и 714_mvm, 717_lvz и 714_lvz. Кастомные вагоны не учитываются
* `717_714_mvm` - применяется только на два энтити - 717_mvm и 714_mvm. Кастомные вагоны не учитываются
* `717_714_lvz` - применяется только на два энтити - 717_lvz и 714_lvz. Кастомные вагоны не учитываются

### Логика загрузки
1. discoverRecipies - поиск всех файлов рецептов
3. loadRecipe - инициализация таблицы RECIPE, сохранение его в таблице MEL.Recipes
4. initRecipe - инициализация рецепта
  1. RECIPE.Init()
  2. Создание конвара для рецепта
  3. Добавление рецепта в MEL.InjectStack
  4. Инициализация RecipeSpecific переменных
2. getTrainEntTables - получение таблиц всех вагонов
5. inject - инжект
  1. на каждом рецепте BeforeInject
  2. на каждый класс поезда:
     1. если InjectNeeded, то InjectSpawner и Inject
     2. injectRandomFieldHelper
     3. injectFieldUpdateHelper
     4. injectFunction
   3. перезагрузка языков
### Инициализация рецепта

Всё. Только одна строчка необходима для задания рецепта - но такой рецепт не будет ничего делать. Именно поэтому, у рецепта возможно определить три метода: 
* `RECIPE:Init()` - поможет для инициализации каких-либо значений, использующихся в рецепте. Вызывается один раз при загрузке (или авторелоуде) рецепта
* `RECIPE:BeforeInject(entclass)` - выполняется перед всеми инжектами. Тут необходимо модицифировать глобальные переменные других рецептов. См [Глобальные переменные](#глобальные-переменные-определенные-рецептами).
* `RECIPE:InjectNeeded(entclass)` - вызывается перед каждым InjectSpawner и Inject. Данная функция должна вернуть `true` или `false` в зависимости от того, нужно ли производить инжект в данный тип вагонов
* `RECIPE:Inject(ent, entclass)` - вызывается на каждой энтити, соответсвующей типу рецепта. В основном тут и происходит весь инжект
* `RECIPE:InjectSpawner(entclass)` - вызывается на каждой энтити, предназначен для инжекта в спавнер. Тут необходимо вызывать методы для работы со спавнером.

Для удобства других разработчиков крайне рекомендуется также задать поле `RECIPE.Description`. Основные правила заполнения этого поля:
* Кратко опишите что делает данный рецепт, что он добавляет.
* Пожалуйста, пишите на английском.
* Все символы в данном поле должны быть печатаемыми.

## Отключение определенного рецепта
Специально для владельцев серверов, которые по определенной причине не хотят использовать какой-либо из рецептов Metrostroi Extensions и прочих аддонов, использующих библиотеку, существует возможность выборочно отключить каждый рецепт. 

Для этого следует задать значение 0 ConVar'у данного рецепта. 

Все ConVar можно посмотреть написав в клиентскую консоль `metrostroi_ext_`. После префикса сначала идет тип энтити для инжекта, а потом название рецепта. 

> [!TIP]
> В helptext ConVar (можно просмотреть, если не указывать значение, а просто написать имя ConVar) указано описание рецепта (Если оно задано автором).

Для некоторых рецептов требуется перезагрузить сервер (и перезайти на клиенте) для того, чтобы рецепт был отключен.

> [!WARNING]
> Пожалуйста, выключайте сервер командой exit - только так значение ваших ConVar будет сохраняться между перезапусками.

## Глобальные переменные, определенные рецептами. (Recipe Specific переменные)
Для возможности кастомизации уже существующих рецептов, в Metrostroi Extensions заложена возможность создания глобальных переменных рецептов. Для этого необходимо просто внутри своего рецепта в функии `RECIPE:Init()` добавить в таблицу `self.Specific` какие-либо значения. После этого эти значения будут доступны всем рецептам через `MEL.RecipeSpecific.<название_значения>` (пожалуйста, далее в рецепте обращайтесь к своей переменной также).

К примеру, почти все стандартные рецепты обладают возможностью кастомизации с помощью таких глобальных таблиц. Изменять эти таблицы нужно в `RECIPE:BeforeInject(entclass)`. Вот описание всех таблиц:

* `MEL.RecipeSpecific.KVList` - типы кв. Таблица таблиц. Формат: 
  * `[1]*` - имя поля в спавнере,
  * `[2]*` - путь до модели
  * `[3]` - callback. Получает энтити вагона и энтити клиентпропа. Необязательный параметр.
* `MEL.RecipeSpecific.VoltmetersList` - типы вольтметров. Таблица таблиц. Формат:
  * `name*` - имя поля в спавнере,
  * `model*` - модель вольтметра,
  * `glow_model` - модель свечения. Может быть nil,
  * `voltmeter_pos*` - положение стрелки вольтметра,
  * `ampermeter_pos*` - положение стрелки амперметра,
  * `hvmeters_buttonmap*` - название баттнмапы с подписями
  * `callback` - callback. Получает энтити вагона и энтити клиентпропа. Необязательный параметр.
* `MEL.RecipeSpecific.SalonSeatList` - типы сидений в салоне. Таблица таблиц. Формат:
  * `name*` - имя поля в спавнере,
  * `head*` - настройки для головного вагона:
    * `model*` - основная модель
    * `cap_model*` - модель "заглушки"
    * `callback` - callback для основной модели. Получает энтити вагона и энтити клиентпропа. Необязательный параметр.
    * `cap_callback` - callback для модели заглушки. Получает энтити вагона и энтити клиентпропа. Необязательный параметр.
  * `int*` - настройки для промежутка:
    * `model*` - основная модель
    * `cap_model*` - модель "заглушки"
    * `cap_o_model` - модель "заглушки" в открытом состоянии. Если не указать, то будет простая заглушка, указанная в `cap_model`
    * `callback` - callback для основной модели. Получает энтити вагона и энтити клиентпропа. Необязательный параметр.
    * `cap_callback` - callback для модели заглушки. Получает энтити вагона и энтити клиентпропа. Необязательный параметр. 
    * `cap_o_callback` - callback для модели заглушки в открытом состоянии. Получает энтити вагона и энтити клиентпропа. Необязательный параметр. 
* `MEL.RecipeSpecific.ARSList` - типы АРС (2 блок). Таблица таблиц. *ВРЕМЕННО НЕАКТУАЛЬНО* Формат:
  * `name*` - имя поля в спавнере,
  * `model*` - модель АРС,
  * `callback` - callback. Получает энтити вагона и энтити клиентпропа. Необязательный параметр.
  * `buttonmap*` - название баттнмапы с ламочками. По умолчанию есть Block2_1, Block2_2, Block2_3. Не бойтесь добавлять свои.
  * `speed_type*` - тип спидометра. По умолчанию есть Top, Left, Arrow
* `MEL.RecipeSpecific.RepairBookList` - типы книг ремонта. Таблица таблиц. Формат:
  * `name*` - имя поля в спавнере,
  * `model` - модель книги ремонта,
  * `pos` - положение книги ремонта.
  * `ang` - угол поворота книги ремонта.
  * `callback` - callback. Получает энтити вагона и энтити клиентпропа. Необязательный параметр.


У внимательного читателя возникнет вопрос: "а в какой тип состава инжектится?". Особой разницы нет, ведь мы просто модифицируем глобальную переменную. Но желательно инжектится по логике - допустим, для KVList актуально инжектится в 717_mvm, а для SalonSeatList - в 717_714_mvm

Пожалуйста, документируйте эти поля для других разработчиков.
## Методы
### Работа с ClientProps
ClientProps - это клиентская таблица, описывающая все клиентские энтити, которые необходимо создать и прицепить к вагону 
#### Описание таблицы ClientProps
* `model` - путь до модели клиентпропа
* `modelcallback` - callback, который позволяет динамически менять модель. Получает энтити самого вагона. Должен вернуть путь до модели. Если этот callback возвращает `nil`, то будет использована модель по умолчанию (тоесть модель, указанная в `model`)
* `pos` - положение клиентпропа относительно координат вагона
* `ang` - угол поворота клиентпропа относительно вагона
* `skin` - скин клиентпропа (по умолчанию равен нулю)
* `scale` - масштаб клиентпропа
* `bscale` - масштаб кости с id=0. Подробнее можно узнать из метода `Entity:ManipulateBoneScale`
* `bodygroup` - таблица бадигруп, где ключ - это id бадигруппы, а значение - значение для этой бадигруппы
* `color` - цвет клиентпропа
* `colora` - цвет клиентпропа с альфа-каналом. Имеет больший приоритет, чем простой `color`
* `callback` - callback, который получает энтити вагона и энтити только что созданного клиентпропа.
* `nohide` - флаг, говорящий о том, что данный клиентпроп нельзя скрывать
* `hide` - если данное значение задано, то оно будет использованно как коэффицент для дальности прорисовки.
* `hideseat` - если данное значение задано, то оно будет использованно как коэффицент для дальности прорисовки, но только если человек сидит в сиденье, не пренадлежащем данному вагону
#### Замена модели через modelcallback - MEL.UpdateModelCallback
`MEL.UpdateModelCallback(ent, clientprop_name, new_modelcallback)` - Обновляет `modelcallback` существующего клиентпропа. 

> [!CAUTION]
> Используйте данную функцию для замены модели у существующего клиентпропа - не стоит вручную обновлять таблицу и заменять model - это может вызвать проблемы у игроков!
        
**Аргументы**:
* *`ent`: энтити вагона, на котором мы должны изменить `modelcallback`
* *`clientprop_name`: имя клиентпропа
* *`new_modelcallback`: Функция, которая получает энтити самого вагона. Должна вернуть путь до модели. Если этот callback возвращает `nil`, то будет использована модель по умолчанию (тоесть модель, указанная в `model`)

**Scope**: `Client`
#### Изменение созданного клиентпропа - MEL.UpdateCallback
`MEL.UpdateCallback(ent, clientprop_name, new_callback)` - Обновляет `callback` существующего clientprop.

> [!CAUTION]
> Используйте данную функцию для изменения позиции/угла и прочего у существующего клиентпропа - не стоит вручную обновлять таблицу и менять какие-либо параметры - это может вызвать проблемы у игроков!

**Аргументы**:
* *`ent`: энтити вагона, на котором мы должны изменить `callback`
* *`clientprop_name`: имя клиентпропа
* *`new_modelcallback`: Функция, которая получает энтити самого вагона и энтити только что созданного клиентпропа.

**Scope**: `Client`
#### Создание нового клиентпропа - MEL.NewClientProp
`MEL.NewClientProp(ent, clientprop_name, clientprop_info, field_name)`
Позволяет создать новый клиентпроп.

**Аргументы**:
* *`ent`: энтити вагона, в котором будет создан новый клиентпроп.  
* *`clientprop_name`: имя  нового клиентпропа
* *`clientprop_info`: информация о клиентпропе. См. [описание таблицы ClientProps](#описание-таблицы-clientprops)
* `field_name`: если этот аргумент передан, тогда данный клиентпроп будет пересоздан при обновлении поля с этим именем в спавнере. Подробнее о автоматической работе с перезагрузкой и рандомом в [Работа со спавнером](#работа-со-спавнером)

**Scope**: `Client`

### Инжект в существующие функции
MetrostroiExtensionsLib позволяет удобно и без конфликтов инжектится в стандартную функцию сразу нескольким рецептам. Для этого используется система приоритетов:
* Функции с негативным приоритетом будут выполнены ДО вызова стандартной функции. Чем меньше значение приоритета, тем раньше данная функция будет вызвана (тоесть, функция с приоритетом -100 будет вызвана раньше, чем функция с приоритетом -10).
* Функции с положительным приоритетом будут выполнены ПОСЛЕ вызова стандартной функции. Чем больше значение приоритета, тем раньше данная функция будет вызвана (тоесть, функция с приоритетом 100 будет вызвара раньше, чем функция с приоритетом 10)
* Функции с приоритетом 0 не может существовать - такой функцией считается стандартная функция

> [!NOTE]
> При вызове `metrostroi_ext_reload` будет выполнен переинжект для всех функций, но для того, чтобы увидеть новые изменения, скорее всего будет требоваться переспавн вагона. Подробнее см. [Перезагрузка](#!)

#### Инжект в клиентскую функцию - MEL.InjectIntoClientFunction
`MEL.InjectIntoClientFunction(ent_or_entclass, function_name, function_to_inject, priority)` - добавляет функцию в очередь для инжекта на клиенте

**Аргументы**:
* *`ent_or_entclass`: энтити или имя энтити, в которую требуется заинжектить данную функцию
* *`function_name`: имя функции, куда будет производится инжект
* *`function_to_inject`: фукнция, которая будет заинжекчена. Принимает энтити (обычно мы называем данный аргумент как self) и все аргументы стандартной функции.
* `priority`: приоритет данной функции в стеке инжекта. Подробнее см. [инжект в существующие функции](#инжект-в-существующие-функции)

**Scope**: `Client`

#### Инжект в серверную функцию - MEL.InjectIntoServerFunction
`MEL.InjectIntoServerFunction(ent_or_entclass, function_name, function_to_inject, priority)` - добавляет функцию в очередь для инжекта на сервере

**Аргументы**:
* *`ent_or_entclass`: энтити или имя энтити, в которую требуется заинжектить данную функцию
* *`function_name`: имя функции, куда будет производится инжект
* *`function_to_inject`: фукнция, которая будет заинжекчена. Принимает энтити (обычно мы называем данный аргумент как self) и все аргументы стандартной функции.
* `priority`: приоритет данной функции в стеке инжекта. Подробнее см. [инжект в существующие функции](#инжект-в-существующие-функции)

**Scope**: `Server`

### Работа со спавнером
MetrostroiExtensionsLib позволяет добавлять новые поля и инжектится в существующие без вреда другим инжектам. MetrostroiExtensionsLib умеет автоматически пересоздавать модели при изменении значения поля спавнера. Также, при добавлении новых полей, MetrostroiExtensionsLib умеет автоматически добавлять необходимый код для работы рандома в списках - *почти* прозрачно для программиста
#### Авторандом
Если при добавлении нового списка через [MEL.AddSpawnerField](#добавить-новое-поле-в-спавнер---MELaddspawnerfield) передать в качестве последнего аргумента `true`, то тогда MetrostroiExtensionsLib автоматически пометит это поле как содержащее рандом в качестве первого элемента.

Тоесть, при выборе первого элемента в данном списке, будет автоматически получено рандомное значение от 2 до длинны списка. Данное значение будет доступно как значение обычного параметра в спавнере (тоесть, данное значение можно будет получить через `self:GetNW2Int("<имя поля>")`).

Если выбран любой другой элемент, то значение поля будет равно `значению поля - 1` (тоесть, если бы элемента рандом в списке не было) 

Пример:
> Есть список VoltmeterType со значениями random, default, round.
> 
> Если выбрать первый элемент, то `self:GetNW2Int("VoltmeterType")` вернет случайное значение от 1 до 2 (так как помимо random, элементов в списке всего два)
>
> Если выбрать второй элемент, то `self:GetNW2Int("VoltmeterType")` вернет значение 1 - ведь данный элемент первый, если не учитывать элемент random
>
> Соответсвенно верно и для третьего элемента - `self:GetNW2Int("VoltmeterType")` вернет 3
#### Автоперезагрузка клиентпропов
MetrostroiExtensionsLib умеет автоматически пересоздавать пересоздавать клиентпропы при обновлении соответсвующего поля в спавнере. Для этого клиентпроп необходимо пометить как "требующий пересоздания" функцией [MEL.MarkClientPropForReload](#пометить-клиентпроп-для-автоперезагрузки---MELmarkclientpropforreload)

Также, при создании клиентпропа функцией [MEL.NewClientProp](#создание-нового-клиентпропа---MELnewclientprop) его можно сразу пометить как "требующий пересоздания" с помощью последнего аргумента - просто передайте туда имя поля

#### Описание таблицы Spawner
* `[1]`* - имя поля
* `[2]`* - отображаемое название как строка. Желательно использовать строку переводов
* `[3]`* - тип поля: `list`, `slider` или `boolean`
* Список (`list`):
     * `[4]`* - таблица со строками - элементы списка (может быть строкой переводов (и скорее всего должна быть)) ИЛИ функция, возвращающая таблицу со строками
    * `[5]` - стандартное значение данного поля
    * `[6]` - callback. Будет вызван для каждого вагона в составе. Получает энтити вагона, значение поля, был ли перевернут данный вагон, индекс вагона, общее количество вагонов, правый ли клик был использован
    * `[7]` - callback. Будет вызван при выборе элемента в списке. Получает объект DComboBox, а также таблицу со всеми панелями, отрисовываемыми спавнером
* Слайдер (`slider`):
    * `[4]`* - количество точек после запятой (см. [DNumSliders:SetDecimals](https://wiki.facepunch.com/gmod/DNumSlider:SetDecimals))
    * `[5]`* - минимальное значение
    * `[6]`* - максимальное значение
    * `[7]` - стандартное значение
    * `[8]` - callback. См. callback списка (`list`) [6].
* Галочка (`boolean`):
    * `[4]` - стандартное значение
    * `[5]` - callback. См. callback списка (`list`) [6].
    * `[6]` - callback. Будет вызван при смене значения галочки. Получает объект DCheckBox, а также таблицу со всеми панелями, отрисовываемыми спавнером.

Если `[1]` это число, пропуск будет добавлен `[1]` раз

Если поле - пустая таблица, пропуск будет добавлен 1 раз

#### Добавить новое поле в спавнер - MEL.AddSpawnerField
`MEL.AddSpawnerField(ent_or_entclass, field_data, is_list_random, overwrite)` - добавляет новое поле в спавнер. Автоматически передобавляет его при перезагрузке.

**Аргументы**:
* *`ent_or_entclass` - энтити или имя энтити вагона, в таблицу Spawner которого необходимо добавить данное поле
* *`field_data` - информация о поле. См. [Описание таблицы Spanwer](#описание-таблицы-spawner)
* `is_list_random` - пометить поле как список, первый элемент которого - рандом
* `overwrite` - если данный флаг - true, то тогда данное поле перезапишется в любом случае. Полезно для замены существующих полей (но используйте с осторожностью!)

**Scope**: `Shared`

#### Пометить клиентпроп для автоперезагрузки - MEL.MarkClientPropForReload
`MEL.MarkClientPropForReload(ent_or_entclass, clientprop_name, field_name)` - помечает клиентпроп как "требующий перезагрузки" при изменении поля с именем `field_name`

**Аргументы**:
* *`ent_or_entclass` - энтити или имя энтити вагона
* *`clientprop_name` - имя клиентпропа
* *`field_name` - имя поля.

**Scope**: `Client`

### Работа с buttonmap
#### Описание таблицы ButtonMap
* `pos` - Положение баттнмапы относительно координат вагона
* `ang` - Угол поворота баттнмапы относительно вагона
* `width` - Ширина баттнмапы
* `height` - Высота баттнмапы
* `scale` - Коэффицент размера баттнмапы
* `sensor` -  ¯\_(ツ)_/¯
* `system` -  ¯\_(ツ)_/¯
* `hide` - если данное значение задано, то оно будет использованно как коэффицент для дальности прорисовки.
* `hideseat` -  если данное значение задано, то оно будет использованно как коэффицент для дальности прорисовки, но только если человек сидит в сиденье, не пренадлежащем данному вагону
* `buttons`: таблица с описанием кнопок
    * `ID` - ID кнопки
    * `x` - x координата кнопки относительно баттнмапы
    * `y` - y координата кнопки относительно баттнмапы
    * `radius` - радиус зоны взаимодействия, используется если `w` или `h` не заданы
    * `w` - ширина зоны взаимодействия
    * `h` - высота зоны взаимодействия
    * `tooltip` - подпись для кнопки.
    * `model`: таблица с описанием модели кнопки
        * `name` - имя модели кнопки. Стандартное значение - ID кнопки
        * `model` - путь до модели кнопки. Стандартное значение - models/metrostroi/81-717/button07.mdl
        * `pos` - позиция модели кнопки относительно позиции кнопки. 
        * `ang` - угол поворота кнопки относительно баттнмапы. 
        * `color` - цвет модели кнопки
        * `colora` - цвет модели кнопки с альфа-каналом. Имеет больший приоритет, чем простой `color`
        * `skin` - скин модели кнопки
        * `hide` - если данное значение задано, то оно будет использованно как коэффицент для дальности прорисовки.
        * `hideseat` - если данное значение задано, то оно будет использованно как коэффицент для дальности прорисовки, но только если человек сидит в сиденье, не пренадлежащем данному вагону
        * `scale` - масштаб модели кнопки
        * `bscale` - масштаб кости с id=0. Подробнее можно узнать из метода `Entity:ManipulateBoneScale`
        * `vmin` - минимальное значение для активации анимации
        * `vmax` - максимальное значение для активации анимации
        * `min` - значение начала анимации
        * `max` - значение конца анимации
        * `speed` - скорость анимации
        * `damping` - демпфирование анимации
        * `stickyness` - "прилипчивость" анимации
        * `var` - сетевая переменная, которая будет использована для активации данной анимации
        * `getfunc` - функция, используемая для получения состояния аниамации. Получает энтити вагона, vmin, vmax, var. Возвращает bool
        * `disable` - если эта кнопка будет включена, тогда кнопка с этим именем будет спрятана. Полезно для крышек.
        * `disableinv` - тоже самое, что и `disable`, но инвертированное
        * `disableoff` и `disableon` - если текущая кнопка выключена, тогда кнопка с именем `disableoff` будет спрятана. Если текущая кнопка включена, тогда кнопка с именем `disableon` будет спрятана.
        * `disablevar` - если эта сетевая переменная будет равна `true`, тогда эта кнопка будет скрыта
        * `sndid` - ID звука. По умолчанию равен ID кнопки
        * `sndvol` - громкость звука. По умолчанию равна 1
        * `sndpitch` - высота звука. По умолчанию равна 1
        * `sndmin` - минимальная дистанция, от которого данный звук будет проигран. По умолчанию равен 100
        * `sndmax` - максимальная дистанция, до которого данный звук будет проигран. По умолчанию равен 1000
        * `sndang` - угол, под которым данный звук будет проигран. По умолчанию равен `Angle(0, 0, 0)`
        * `snd` - функция. Получает булево значение сетевой переменной (выражение `var > 0`) и сырую переменную. Должна вернуть ID звука, который необходимо проиграть.
        * `plomb`: таблица, описывающия пломбу
            * все переменные, описывающие модель (pos, z, x, y, ang, color, skin, hide, hideseat, bscale, scale) как в таблице model И
            * `var` - сетевая переменная, которая будет переключать данную пломбу
        * `lamp`: таблица, описывающая лампочку
            * все переменные, описывающие модель (pos, z, x, y, ang, color, skin, hide, hideseat, bscale, scale) как в таблице model И
            * `anim` - флаг, обозначающий то, нужно ли анимировать данную лампочку ровно также, как и модель кнопки
            * `var` - сетевая переменная, управляющая анимайцией данной лампочки
            * `min` - значение начала анимации
            * `max` - значение конца анимации
            * `speed` - скорость анимации
            * `getfunc` - функция, используемая для получения состояния аниамации. Получает энтити вагона, vmin, vmax, var. Возвращает bool
            * `hidden` -  ¯\_(ツ)_/¯
        * `lamps`: таблица с множеством объектов, описывающих лампы. Имеют формат как таблица `lamp`.
        * `labels`: таблица с множеством объектов, описывающих "подписи". Объекты содержат все переменные описывающие модель (pos, z, x, y, ang, color, skin, hide, hideseat, bscale, scale) как в таблице model. Позволяет добавить статичные модели (модели, которые не будут зависимы от какой либо сетевой переменной)

#### Переместить существующую баттнмапу - MEL.MoveButtonMap
`MEL.MoveButtonMap(ent, buttonmap_name, new_pos, new_ang)` - перемещает существующую баттнмапу на новое место

**Аргументы**:
* *`ent`: энтити вагона, в котором будет изменено местоположение баттнмапы
* *`buttonmap_name`: имя баттнмапы, которую надо переместить
* *`new_pos`: новое местоположение баттнмапы
* `new_ang`: новый угол поворота баттнмапы. Не передавайте данный аргумент, если не хотите менять угол поворота баттнмапы

**Scope**: `Client`

#### Создать новую баттнмапу - MEL.NewButtonMap
`MEL.NewButtonMap(ent, buttonmap_name, buttonmap_data)` - создает новую баттнмапу

**Аргументы**:
* *`ent`: энтити вагона, в котором будет создана баттнмапа
* *`buttonmap_name`: имя баттнмапы
* *`buttonmap_data`: [таблица с описанием баттнмапы](#описание-таблицы-buttonmap)

**Scope**: `Client`


# Полезные инструкции
## Автоматический metrostroi_ext_reload при сохранении файла
Для автоматического релоуда мы будем использовать File Watcher. В разных IDE они настраиваются по разному, но я покажу как настроить его в vscode с дополнением https://marketplace.visualstudio.com/items?itemName=appulate.filewatcher.
1. Создадим конфигурацию в .vscode/settings.json:
```
{
  "filewatcher.commands": [
      {
          "match": "\\.lua*",
          "isAsync": true,
          "cmd": "python3 ${currentWorkspace}/scripts/reload.py",
          "event": "onFileChange"
      }		
  ]
}
```
2. Создадим настройки для скрипта по пути {путь до папки с экстом}/scripts/.env
```
RCON_IP={ваш ip address сервера}
RCON_PORT={порт RCON}
RCON_PASSWORD={пароль RCON}
```
3. Настроим python: установим зависимости: выполним данную команду, находясь в папке scripts
`python3 -m pip install -r requirements.txt`
> Примечание: в идеале настроить venv :)
4. Готово!

Проверьте, как работает ваш авторелоуд - если при сохранении файла в консоль сервера выводится уведомление о том, что рецепты перезагружены - то все хорошо. Если данный способ не сработал - проверьте, что плагин File Watcher работает. Для этого в нижней строке найдите значок телескопа и нажмите на него - он должен гореть зеленым