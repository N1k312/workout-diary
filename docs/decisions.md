# Architecture Decision Records (ADR)

> Workout Diary — Flutter app project  
> Сводный документ ключевых решений, принятых на стадии планирования.  
> Формат: каждое решение → контекст → вариант выбран → альтернативы → обоснование.
>
> **Версия 2** — с исправлениями несоответствий (удалён Storage, уточнён rest timer, добавлены комментарии про reserved поля).

---

## Содержание
1. [Архитектура и стек](#архитектура-и-стек)
2. [Scrum процесс](#scrum-процесс)
3. [Дизайн-система](#дизайн-система)
4. [Firestore и данные](#firestore-и-данные)
5. [Аутентификация](#аутентификация)
6. [Экраны и UX](#экраны-и-ux)
7. [Active Workout — core decisions](#active-workout--core-decisions)
8. [MVP scope](#mvp-scope)
9. [Дополнительные решения (v2)](#дополнительные-решения-v2)

---

## Архитектура и стек

### ADR-01: Feature-first structure
**Выбрано:** папки организованы по фичам (`features/workout/`, `features/exercises/`), а не по слоям.  
**Альтернатива:** layer-first (`screens/`, `widgets/`, `providers/`).  
**Обоснование:** масштабируемость, меньше git-конфликтов, фичи независимы. Для соло-проекта проще навигация.

### ADR-02: Riverpod для state management
**Выбрано:** `flutter_riverpod` 3.x с 3 типами провайдеров (`Provider`, `StreamProvider`, `AsyncNotifierProvider`).  
**Альтернатива:** Bloc, Provider (классический), GetX.  
**Обоснование:** compile-time safe, меньше бойлерплейта, хорошая совместимость с Freezed. Меньше магии чем GetX.

### ADR-03: Repository pattern + Service layer
**Выбрано:** разделение на Service (Firebase API) + Repository (бизнес-логика сущности).  
**Альтернатива:** один Repository, который и Firebase зовёт и логику делает.  
**Обоснование:** тестируемость (моки service), возможность замены источника данных, SOLID (SRP).

### ADR-04: Abstract interfaces для репозиториев
**Выбрано:** `IWorkoutRepository` (abstract) + `FirebaseWorkoutRepository` (impl).  
**Альтернатива:** только конкретные классы; или Dart-idiomatic `WorkoutRepository` + `FirebaseWorkoutRepository`.  
**Обоснование:** dependency inversion (DIP), замена реализации на одной строке в Provider, mock-friendly для тестов. I-prefix не идиоматичен для Dart (C# style), выбран осознанно для визуальной ясности в учебном проекте.

### ADR-05: Freezed для моделей
**Выбрано:** `freezed` 3.x + `json_serializable` 6.x.  
**Альтернатива:** plain Dart классы.  
**Обоснование:** immutability, auto-generated `toJson`/`fromJson`/`copyWith`/`==`, меньше багов с состоянием.

### ADR-06: go_router для навигации
**Выбрано:** `go_router` 17.x с декларативной конфигурацией и ShellRoute для bottom nav.  
**Альтернатива:** Navigator 1.0, auto_route.  
**Обоснование:** декларативность, type-safety, redirect логика (auth guards), рекомендован Flutter team.

### ADR-07: Offline-first
**Выбрано:** Firestore offline persistence включён (`cacheSizeBytes: CACHE_SIZE_UNLIMITED`).  
**Альтернатива:** только online работа.  
**Обоснование:** в зале может не быть связи. Firestore сам кэширует и синхронизирует. UX не ломается.

### ADR-08: Multi-device sync через StreamProvider
**Выбрано:** все данные — через `StreamProvider`, Firestore делает real-time sync между устройствами.  
**Альтернатива:** Future-based, ручной refresh.  
**Обоснование:** "из коробки" кросс-девайс синхронизация при залогинивании с двух устройств.

### ADR-09: Error handling — AppException + mapping в Repository
**Выбрано:** sealed `AppException` иерархия (AuthException, NetworkException, ValidationException, NotFoundException, UnknownException). Service бросает Firebase errors → Repository мапит в AppException → Provider → UI через `AsyncValue.when`.  
**Альтернатива:** сырые Firebase exceptions до UI.  
**Обоснование:** чистые доменные ошибки, локализация сообщений, UI не знает про Firebase.

### ADR-10: SnackBar для ошибок действий, ErrorWidget для списков
**Выбрано:** SnackBar (non-blocking) для transient errors (save, delete). Полный ErrorWidget для failed list loads.  
**Альтернатива:** dialog для всех ошибок / toast только.  
**Обоснование:** SnackBar не блокирует UX, ErrorWidget — явное состояние экрана "данные не загружены".

### ADR-11: Firebase Emulator в debug
**Выбрано:** `useAuthEmulator` + `useFirestoreEmulator` if `kDebugMode`.  
**Альтернатива:** использовать production Firebase в dev.  
**Обоснование:** не жжём квоты, быстрее, можно seed тестовых данных, не ломаем prod.

### ADR-12: Денормализация exerciseName в workouts
**Выбрано:** в `Workout.exercises[].exerciseName` сохраняем имя exercise дублированно.  
**Альтернатива:** хранить только ID, при чтении joinить.  
**Обоснование:** Firestore не умеет joins. Read дешевле write. Имя exercise почти не меняется (custom можно переименовать — но старые workouts отражают состояние на момент).

### ADR-13: User-scoped data под `users/{uid}/...`
**Выбрано:** все user data как subcollections документа user.  
**Альтернатива:** плоские коллекции с `userId` полем.  
**Обоснование:** простые security rules (один `isOwner(userId)`), чёткая модель прав доступа, предсказуемая структура.

### ADR-14: Global `exercises` collection
**Выбрано:** seed + custom exercises в одной глобальной коллекции, разграничение по `createdBy` и `isCustom`.  
**Альтернатива:** custom exercises в `users/{uid}/exercises`.  
**Обоснование:** единый API, переиспользование фильтров/поиска, security rules позволяют read all + write only own custom.

---

## Scrum процесс

### ADR-15: Упрощённый Scrum для соло-разработчика
**Выбрано:** без ежедневных standup, без отдельной retrospective встречи, без velocity подсчёта. Оставлены: backlog, sprint planning (15 мин), sprint review (10 мин), retrospective (5 мин в файле).  
**Обоснование:** соло-формат; полный Scrum для команды, половина церемоний для одного человека — театр.

### ADR-16: Sprint Board
**Выбрано:** primary — `workout_backlog.xlsx` как source of truth. Optional — GitHub Projects kanban для визуализации.  
**Альтернатива:** только Trello/Jira.  
**Обоснование:** xlsx удобен для отчётности преподавателю, GitHub Projects даёт бесплатный burndown если подключить.

### ADR-17: DEVLOG.md + retrospectives.md
**Выбрано:** дневной лог в корне репо + Start-Stop-Continue retrospectives по спринтам.  
**Обоснование:** артефакты для защиты (показывают процесс), низкая overhead (2 строки в день).

### ADR-18: Conventional Commits
**Выбрано:** `feat:`, `fix:`, `refactor:`, `test:`, `docs:`, `chore:` с feature branches.  
**Обоснование:** стандарт индустрии, читаемая история, возможность автогенерации changelog.

### ADR-19: MVP через MOSCOW приоритизацию
**Выбрано:** 61 Must Have stories в MVP (sprints 1-6), остальные (28 Should + 8 Nice = 36) — Out of MVP backlog.  
**Обоснование:** реалистичная velocity (12-15 SP/sprint × 6 = 90 SP) покрывает только Must Have. Остальное — next iteration.

---

## Дизайн-система

### ADR-20: Тёмная тема по умолчанию
**Выбрано:** dark theme default, опция переключения на light в settings.  
**Обоснование:** fitness apps используются в зале (плохой свет), OLED экраны = экономия батареи, меньше eye strain.

### ADR-21: Акцентный цвет #3B82FF (синий)
**Выбрано:** blue accent.  
**Альтернатива:** зелёный (fitness стандарт), красный (энергия).  
**Обоснование:** нейтральный, не воспринимается как "болезненный" (красный) или "эко" (зелёный), хорошая контрастность с тёмным фоном.

### ADR-22: Inter вместо SF Pro
**Выбрано:** Inter (SIL Open Font License) через `google_fonts`.  
**Альтернатива:** SF Pro (Apple, лицензия ограничена iOS/macOS).  
**Обоснование:** юридическая чистота на Android (SF Pro нельзя использовать в Android apps). Inter визуально на 95% идентичен SF Pro.

### ADR-23: Lucide Icons
**Выбрано:** `lucide_icons` package.  
**Альтернатива:** Material Icons, Material Symbols Rounded.  
**Обоснование:** современный дизайн (thin strokes, консистентная сетка), подходит минималистичной тёмной теме.

### ADR-24: 8-point spacing grid
**Выбрано:** 4 / 8 / 12 / 16 / 24 / 32 / 48.  
**Обоснование:** стандарт индустрии, чистая математика, предсказуемые align.

### ADR-25: Английский UI
**Выбрано:** все UI строки на английском.  
**Альтернатива:** русский или bilingual.  
**Обоснование:** международный портфолио-проект, стандартная terminology в fitness, легче defense без путаницы переводов.

---

## Firestore и данные

### ADR-26: Soft delete для custom exercises
**Выбрано:** flag `isDeleted: true`, exercise не показывается в library но сохраняется в Firestore.  
**Альтернатива:** hard delete.  
**Обоснование:** старые workouts ссылаются на exercise (через ID и денормализованное имя). Hard delete сломает историю. Для workouts hard delete — тренировка standalone, нет downstream зависимостей.

### ADR-27: PR формула — Epley 1RM
**Выбрано:** `estimated 1RM = weight × (1 + reps / 30)`.  
**Альтернатива:** max weight за подход, total volume.  
**Обоснование:** стандарт в fitness apps (Strong, Hevy), справедливое сравнение подходов разной интенсивности (100kg × 1 vs 80kg × 10).

### ADR-28: Resume unfinished workout через Firestore
**Выбрано:** `Workout.finishedAt == null` → показываем Resume banner на Home при запуске.  
**Альтернатива:** SharedPreferences local state.  
**Обоснование:** кросс-девайс resume, single source of truth, данные уже в Firestore.

### ADR-29: Firestore writes debounce 1 sec
**Выбрано:** после изменения подхода — debounce 1 сек, затем batch write.  
**Альтернатива:** немедленная запись на каждое изменение.  
**Обоснование:** уменьшение квоты Firestore (важно на free tier), меньше нагрузки на сеть.

### ADR-30: Seed data через Firebase CLI
**Выбрано:** `firebase firestore:import` один раз при setup, 30 exercises захардкожены в JSON.  
**Альтернатива:** клиент заливает при первом запуске, Cloud Function.  
**Обоснование:** чище, без race conditions, одноразовая операция.

---

## Аутентификация

### ADR-31: Email + Google Sign-In
**Выбрано:** два метода входа.  
**Альтернатива:** + Apple, + Anonymous, + Phone.  
**Обоснование:** покрывает 95% сценариев, Apple требует deploy в App Store (не делаем), Phone uses SMS quota.

### ADR-32: Точные сообщения Firebase ошибок
**Выбрано:** "Wrong password", "User not found", "Email already registered".  
**Альтернатива:** generic "Invalid credentials".  
**Обоснование:** лучше UX. Security trade-off известен (user enumeration) — для учебного проекта acceptable, в production стоит рассмотреть.

### ADR-33: Min 6 chars password (Firebase default)
**Выбрано:** только Firebase default (≥6).  
**Альтернатива:** + strength indicator, + требование цифр/символов.  
**Обоснование:** Firebase enforcement достаточно для учебного проекта. Strength indicator — Nice to Have.

### ADR-34: Confirm password field
**Выбрано:** поле "Confirm password" в Register.  
**Альтернатива:** убрать (полагаться на show/hide).  
**Обоснование:** защита от опечаток (юзер не сможет войти если ошибся). Trade-off: +1 поле.

### ADR-35: Email verification — НЕ в MVP
**Выбрано:** после регистрации сразу в app без email confirmation.  
**Обоснование:** для учебного проекта overhead не оправдан. В production — must have.

---

## Экраны и UX

### ADR-36: Splash с lazy progress bar
**Выбрано:** прогресс-бар появляется после 800ms (fade-in), не блокирует при быстрой загрузке.  
**Обоснование:** на медленных устройствах не выглядит как зависание, на быстрых — не моргает.

### ADR-37: Home — 1 последняя тренировка + N PR + weekly stats
**Выбрано:** минималистичный Home: greeting + 2 stat cards + last workout + PR horizontal scroll + Start button.  
**Альтернатива:** много секций, всё видно.  
**Обоснование:** "лицо" приложения, не перегружаем. История полная — на отдельной вкладке.  
**Примечание:** Home — не отдельная story, а aggregation экран (собирается из workouts + PRs + profile). Реализуется в Sprint 5.

### ADR-38: Weekly stats с сравнением vs last week
**Выбрано:** `3 workouts (↑ 1 vs last week)`.  
**Обоснование:** мотивация, визуальный прогресс, минимум logic.

### ADR-39: Exercise icons — буквы в цветных кружках по muscle group
**Выбрано:** "Ch" (chest) blue, "Ba" (back) green, etc. — 7 кругов по 7 групп.  
**Альтернатива:** эмодзи, иллюстрации упражнений, один generic иконка.  
**Обоснование:** консистентно, масштабируемо (новое упражнение = тот же цвет группы), без лицензий на иллюстрации.

### ADR-40: Exercise Picker — bottom sheet 85%
**Выбрано:** bottom sheet с multi-select, вместо full-screen modal.  
**Обоснование:** сохраняет контекст workout, mobile-native UX, быстрый swipe down.

### ADR-41: Reorder exercises drag-and-drop
**Выбрано:** `ReorderableListView` в Workout Start.  
**Обоснование:** стандарт в gym apps, юзеры хотят контроль порядка (разминка → compound → изоляция).

### ADR-42: Pinned SearchBar в Exercise Library
**Выбрано:** SearchBar прикреплён сверху при скролле, FilterChips скроллятся с контентом.  
**Обоснование:** поиск должен быть всегда доступен, фильтр — реже нужен.

### ADR-43: "Create '{query}'" shortcut в empty search
**Выбрано:** если поиск не нашёл — кнопка создать custom exercise с pre-filled name.  
**Обоснование:** 2 часа работы, большой UX выигрыш — юзер не теряется при отсутствии результатов.

### ADR-44: History группировка по месяцам
**Выбрано:** sticky header "March 2026", workouts под ним.  
**Альтернатива:** flat список с датой на карточке.  
**Обоснование:** ориентация во времени, "знакомые" фитнес-app паттерны.

### ADR-45: Period picker 1M / 3M / 6M / 1Y / All
**Выбрано:** segmented control с 5 значениями.  
**Обоснование:** покрывает типичные fitness periods, default 3M — баланс между context и detail.

### ADR-46: Profile — settings inline, не отдельный экран
**Выбрано:** theme/units/rest/sound как rows в Profile screen.  
**Альтернатива:** Settings как отдельный экран.  
**Обоснование:** меньше экранов, всё рядом, скролл один.

### ADR-47: Delete account требует password re-entry
**Выбрано:** confirm dialog с input поля пароля.  
**Альтернатива:** просто confirm "Are you sure?".  
**Обоснование:** Firebase security requirement для recent authentication. Защита от случайных/злонамеренных удалений.

---

## Active Workout — core decisions

### ADR-48: Custom numpad вместо стандартной клавиатуры
**Выбрано:** bottom sheet с крупными кнопками (56×56px min), только цифры + dot + backspace + Done.  
**Альтернатива:** стандартная `TextInputType.number` клавиатура.  
**Обоснование:** core UX. Стандартная клавиатура: decimal в странном месте, маленькие кнопки, медленно. Кастомный = fitness-first, дифференциатор продукта.

### ADR-49: Auto-fill подходов из прошлой тренировки
**Выбрано:** при Add Set — weight/reps pre-filled из того же номера подхода прошлой тренировки этого exercise. Fallback: предыдущий подход текущей тренировки.  
**Обоснование:** уменьшает трение (1-2 тапа на подход при прогрессирующей нагрузке), "умная" подсказка.

### ADR-50: Prev column всегда показываем
**Выбрано:** колонка "Prev" в таблице подходов с last workout's same set.  
**Альтернатива:** toggle в settings.  
**Обоснование:** 90% полезной информации экрана. Юзер должен знать с чем работал в прошлый раз — это основа прогрессирующей нагрузки.

### ADR-51: Rest timer — single user default (90 сек)
**Выбрано:** один глобальный default для всех упражнений, хранится в `UserProfile.defaultRestTimer`. Настраивается в Profile.  
**Альтернатива:** per-exercise override (раньше планировалось, убрано для упрощения MVP).  
**Обоснование:** простота схемы — одно поле в UserProfile, нет дополнительного хранилища per-exercise. 90 сек — медиана bodybuilding range (60-120 сек). Per-exercise override можно добавить в Nice to Have backlog.

### ADR-52: Vibration always ON, sound default OFF
**Выбрано:** haptic feedback всегда, звук — toggle в settings (default off).  
**Обоснование:** gym etiquette — звуки раздражают соседей. Vibration приватна.

### ADR-53: PR detection при checkmark + congrats в finish
**Выбрано:** Badge 🏆 появляется на подходе сразу при check. Sheet с полным списком PR — при Finish.  
**Обоснование:** двойная feedback loop: immediate (мотивация) + summary (удовлетворение).

### ADR-54: Haptic medium для regular, heavy для PR
**Выбрано:** `HapticFeedback.mediumImpact` для обычного подхода, `heavyImpact` для PR.  
**Обоснование:** иерархия feedback по важности события.

### ADR-55: Wakelock только на Active Workout
**Выбрано:** `wakelock_plus.enable()` при открытии Active Workout, `disable()` при выходе.  
**Альтернатива:** wakelock на всё приложение.  
**Обоснование:** экономия батареи. Screen должен оставаться активным только в зале.

### ADR-56: Finish button всегда enabled + dialog
**Выбрано:** кнопка никогда не disabled. Tap → confirm dialog с summary.  
**Альтернатива:** disabled если 0 completed sets.  
**Обоснование:** юзер может хотеть discard workout — не принуждаем делать sets. Dialog даёт контроль.

### ADR-57: Timer через timestamps, не счётчик
**Выбрано:** храним `startTime`, UI вычисляет `now - startTime`, rebuild через `Timer.periodic(1 sec)`.  
**Альтернатива:** инкремент счётчика каждую секунду.  
**Обоснование:** устойчиво к app pause/resume, точно при background/foreground transitions.

---

## MVP scope

### ADR-58: Вырезано из MVP
Следующие функции — в backlog как Out of MVP:
- **Шаблоны тренировок** (4 stories) — архитектурно дубль тренировки
- **Body weight tracking + chart** (2 stories) — отдельная модель данных
- **Streak** (1 story) — feature crawl, можно добавить потом
- **Muscle groups distribution chart** (1 story) — сложный UI, не core value
- **PDF / JSON export/import** (3 stories) — отдельное направление
- **Push-уведомления** (1 story) — нужны FCM setup + Cloud Functions
- **Фото профиля** (1 story) — требует Firebase Storage (Blaze plan), вырезано чтобы остаться на free Spark
- **Cardio logging** (1 story) — другая модель данных
- **Локализация (ru/en)** (1 story) — +2 дня работы
- **Поделиться тренировкой** (1 story) — share image generation
- **Избранное упражнения** (1 story) — nice to have
- **Equipment фильтр** (1 story) — nice to have
- **Мышечная схема** (1 story) — сложная иллюстрация
- **Notes для тренировки** (1 story) — поле `notes` зарезервировано в схеме, но UI не реализуем
- **Per-exercise rest timer override** — упрощено до single default в Profile
- **Google Sign-In** — google_sign_in 7.x требует SHA-1 keystore + не работает с Auth Emulator; email auth достаточен для MVP (см. ADR-65)

**Итого вырезано:** 30 stories / 91 SP.

### ADR-59: Stretch goals (если останется время после S1-S6)
Приоритет добавления из backlog (сверху вниз):
1. **Rest timer local notifications** (push при окончании, через `flutter_local_notifications` — не FCM)
2. **Body weight tracking** (полезно для gym app)
3. **Streak counter** (мотивация)
4. **Workout templates** (часто запрашиваемая фича)
5. **Per-exercise rest timer override** (advanced setting)

---

## Дополнительные решения (v2)

### ADR-60: Firebase Storage НЕ используем
**Выбрано:** только Firebase Auth + Firestore. Storage не подключён.  
**Причина:** Firebase Storage требует платный Blaze plan с привязкой карты. Фото профиля вырезано из MVP, других кейсов для Storage нет.  
**Следствия:**
- Нет `StorageService` в `data/services/`
- Нет `firebase_storage` в pubspec
- `UserProfile.photoUrl` — nullable, зарезервировано forward-compat
- Аватар в UI = initials в цветном круге

### ADR-61: FCM НЕ используем, используем local notifications
**Выбрано:** `flutter_local_notifications` для rest timer (если будем делать). НЕ Firebase Cloud Messaging.  
**Причина:** FCM требует Cloud Functions для отправки, сложно настраивать, overkill для учебного проекта. Local notifications достаточно для rest timer use case.  
**Следствия:** нет `firebase_messaging` в pubspec, нет FCM setup в Android manifest.

### ADR-62: AppUser vs UserProfileModel — разделение
**Выбрано:** два отдельных класса с чёткими ролями.  
- `AppUser` — lightweight, только Firebase Auth данные (uid, email). Используется в auth state stream, router guards.
- `UserProfileModel` — full profile из Firestore. Используется для settings, Home greeting, stats.

**Обоснование:** разные источники данных, разные жизненные циклы. AppUser существует с момента логина, UserProfileModel — после создания документа в Firestore.

### ADR-63: totalVolume и duration — precomputed в Workout
**Выбрано:** поля вычисляются один раз при `Workout.finish()` и хранятся в документе.  
**Альтернатива:** вычислять на лету из sets при каждом чтении.  
**Обоснование:** History list отображает N тренировок — не должен делать N×M вычислений. Precompute на записи = быстрое чтение.  
**Trade-off:** если sets модифицируются после finish (edge case), надо пересчитать. Это редкий кейс — принимаем.

### ADR-64: `notes` и `photoUrl` — reserved fields
**Выбрано:** поля есть в схеме, nullable, UI не реализован в MVP.  
**Обоснование:** forward-compatibility — при добавлении фич в будущих итерациях не нужна миграция схемы. Добавить только UI.  
**Важно для Claude Code:** НЕ создавать UI для этих полей в MVP.

### ADR-65: Google Sign-In вырезан из MVP
**Выбрано:** только email/password authentication в MVP. Google Sign-In кнопки остаются в UI как disabled placeholders.  
**Причина:**
- google_sign_in 7.x имеет новый initialization API, требует тщательной настройки SHA-1 debug keystore
- Не работает с Firebase Auth Emulator — требует реальный Firebase проект для тестов
- Email auth полностью покрывает паттерны (Service → Repository → Provider → UI), которые важны для защиты
- Экономия ~45 минут на реально ценные фичи (Active Workout, models, tests)

**Следствия:**
- GoogleButton в Login/Register остаётся с onPressed: null
- UI показывает наличие feature, implementation отложен на post-MVP
- На защите: "архитектурно подготовлено, интеграция отложена в пользу core UX"

---

## Приложение: диаграмма архитектуры

```
┌─────────────────────────────────────────────────────────┐
│                   UI Layer                              │
│  Screens (ConsumerWidget) — Widgets — go_router         │
└────────────────────────────┬────────────────────────────┘
                             │ ref.watch / ref.read
┌────────────────────────────▼────────────────────────────┐
│              State Management (Riverpod)                │
│    AsyncNotifierProvider  |  StreamProvider             │
└────────────────────────────┬────────────────────────────┘
                             │
┌────────────────────────────▼────────────────────────────┐
│                Repository Layer (интерфейсы)            │
│   IWorkoutRepo | IExerciseRepo | IAuthRepo | IUserRepo  │
└────────────────────────────┬────────────────────────────┘
                             │
┌────────────────────────────▼────────────────────────────┐
│          Repository Layer (Firebase реализации)         │
│   FirebaseWorkoutRepo | FirebaseExerciseRepo | ...      │
└────────────────────────────┬────────────────────────────┘
                             │
┌────────────────────────────▼────────────────────────────┐
│                 Service Layer                           │
│         FirestoreService  |  AuthService               │
│         (NO StorageService — Firebase Storage not used) │
└────────────────────────────┬────────────────────────────┘
                             │
┌────────────────────────────▼────────────────────────────┐
│                  Firebase SDK                           │
│            Firestore  |  Auth                           │
│   (NO Storage — Blaze plan required, cut from MVP)      │
│   (NO FCM — using flutter_local_notifications instead)  │
└─────────────────────────────────────────────────────────┘

Models (Freezed) — используются на всех слоях, не зависят ни от чего
```

---

## Приложение: Firestore schema

```
users/{userId}
  ├── email, name, goal, age, height, weight, units
  ├── defaultRestTimer (seconds)       // single value, no per-exercise override in MVP
  ├── soundEnabled
  ├── photoUrl                         // RESERVED, nullable, no UI in MVP
  ├── createdAt
  │
  ├── workouts/{workoutId}
  │   ├── name, startedAt, finishedAt
  │   ├── duration                     // PRECOMPUTED on finish
  │   ├── totalVolume                  // PRECOMPUTED on finish
  │   ├── notes                        // RESERVED, nullable, no UI in MVP
  │   └── exercises: [
  │         { exerciseId, exerciseName (denormalized), order,
  │           sets: [{ weight, reps, isCompleted, estimatedOneRM }] }
  │       ]
  │
  └── personalRecords/{exerciseId}
      └── estimatedOneRM, weight, reps, workoutId, updatedAt

exercises/{exerciseId}   (global, read-all)
  └── name, muscleGroup (enum), equipment (enum),
      isCustom, createdBy, isDeleted, description
```

---

## Статистика решений

- **Всего ADR:** 64 (59 оригинальных + 5 новых для v2)
- **Обсуждено экранов:** 14
- **Stories in MVP:** 61 (Must Have)
- **Stories out of MVP:** 36 (Should + Nice Have backlog)
- **Sprints:** 6 × 3 дня = 18 дней + 12 buffer days
- **Target velocity:** 12-15 SP/sprint
