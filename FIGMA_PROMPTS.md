# Figma Prompts — Workout Diary Mockups

> Промпты для генерации макетов в Figma через Claude Code + Figma MCP.  
> Используй в CLI: `claude` → вставь промпт.

## Подготовка (один раз)

Перед первым промптом создай в Figma файл:
- Размер фрейма: **390 × 844px** (iPhone 14)
- Создай страницу `Mockups`
- Создай страницу `Design System`
- Убедись что Figma MCP подключён в Claude Code (`claude mcp list`)

## Глобальные токены (промпт 0 — запусти первым)

```
Ты работаешь в Figma через MCP. Открой файл "Workout Diary" и перейди на страницу "Design System".

Создай design tokens как local variables в Figma:

COLORS (collection "Colors"):
Background:
  - bg-primary: #0A0A0A
  - bg-secondary: #141414
  - bg-tertiary: #1F1F1F

Accent:
  - accent-primary: #3B82FF
  - accent-hover: #5C95FF

Text:
  - text-primary: #FFFFFF
  - text-secondary: #A3A3A3
  - text-tertiary: #666666
  - text-on-accent: #FFFFFF

Semantic:
  - success: #10B981
  - warning: #F59E0B
  - error: #EF4444

Borders:
  - border-default: #262626
  - border-focus: #3B82FF

Muscle groups:
  - muscle-chest: #3B82FF (blue)
  - muscle-back: #10B981 (green)
  - muscle-legs: #8B5CF6 (purple)
  - muscle-shoulders: #F59E0B (amber)
  - muscle-biceps: #F97316 (coral)
  - muscle-triceps: #14B8A6 (teal)
  - muscle-core: #EC4899 (pink)

TYPOGRAPHY (text styles, font Inter):
  - displayLarge: 32 / Bold / 40 line
  - headlineLarge: 24 / Bold / 32 line
  - headlineMedium: 20 / SemiBold / 28 line
  - titleLarge: 18 / SemiBold / 24 line
  - titleMedium: 16 / Medium / 22 line
  - bodyLarge: 16 / Regular / 24 line
  - bodyMedium: 14 / Regular / 20 line
  - bodySmall: 13 / Regular / 18 line
  - labelSmall: 12 / Medium / 16 line

SPACING (numbers collection):
  - xs: 4, sm: 8, md: 12, base: 16, lg: 24, xl: 32, xxl: 48

RADII (numbers collection):
  - radius-sm: 8, radius-md: 12, radius-lg: 16, radius-xl: 24, radius-pill: 999
```

## Компоненты (промпт 1)

```
На странице "Design System" создай компоненты (components):

1. AppLogo — icon dumbbell с цветом accent-primary, варианты size: 24/32/64

2. PrimaryButton — height 56, radius-md, bg accent-primary, text white titleMedium, padding 16/24.
   Variants: default, loading (spinner), disabled

3. SecondaryButton — height 56, radius-md, bg transparent, border 1px border-default, text white.
   Variants: default, loading, disabled

4. TextButton — bg transparent, text accent-primary bodyMedium.
   Variants: default, pressed

5. TextInput — height 52, radius-md, bg bg-tertiary, padding 16, text titleMedium.
   Variants: default, focus (border accent), error (border error), disabled.
   Slots: suffix icon, helper text, error text

6. FilterChip — height 36, radius-pill, padding 8/14.
   Variants: selected (bg accent, text white), unselected (bg transparent, border border-default, text text-secondary)

7. Chip (Custom badge) — height 20, radius-pill, bg transparent, border 0.5 accent-primary, 
   text accent-primary 10px, padding 1/6

8. Card — bg bg-secondary, radius-md, padding base

9. SectionHeader — row with title (titleLarge) + optional action (TextButton "View all →")

10. Bottom Navigation — height 72, bg bg-primary, border-top 0.5 border-default.
    5 slots with Lucide icons: home, list (history), plus (FAB), dumbbell (exercises), user (profile).
    Active tab: icon accent-primary. Inactive: icon text-tertiary.
    FAB slot: circle 48, bg accent-primary, icon plus white.

11. AppBar — height 56, bg bg-primary, padding 16.
    Variants: with back (arrow-left), with title, with action, greeting (logo + name)

12. MuscleGroupBadge — circle size 40 or 64.
    bg = muscle-{group} with 20% opacity, text = muscle-{group} full opacity.
    Label = 2 letters (Ch/Ba/Le/Sh/Bi/Tr/Co), Inter Medium 13px.

13. ExerciseCard — full-width card, padding 14.
    Row: MuscleGroupBadge 40 + text block (name titleMedium white, subtitle bodySmall text-secondary) + chevron-right icon text-tertiary.
    Subtitle shows: "Equipment · PR Xkg × N" or "Equipment · No data yet".
    Optional: Custom badge next to name.

14. SetRow — для Active Workout. 5 columns: Set # (labelSmall) | Prev (bodySmall text-secondary) | Weight (headlineMedium white) | Reps (headlineMedium white) | Checkmark circle.
    States: pending (all white), active (subtle bg accent 10%), done (strikethrough, text-secondary).

15. StatCard — square aspect ratio, bg bg-secondary, radius-md, padding base.
    Layout: big number (headlineLarge) + label (bodySmall text-secondary). Optional comparison indicator (↑/↓ with color).

16. PRCard — card 140x120, radius-md, bg bg-secondary, padding 14.
    trophy icon amber + exercise name (titleMedium) + "Xkg × N" (headlineMedium) + date (bodySmall text-secondary)

17. EmptyState — vertical column centered.
    Icon Lucide (size 48, color text-tertiary) + title (titleLarge white) + description (bodyMedium text-secondary) + optional PrimaryButton

18. SnackBar — bottom sheet style, bg bg-secondary, radius-md, padding 12/16, border-left 3px.
    Variants: success (border success), error (border error), info (border accent).
```

## Экран 1: Splash

```
Создай фрейм 390x844 "Splash" на странице Mockups.
Фон: bg-primary.
Центр: AppLogo size 64.
Под логотипом через 16px: "Workout Diary" (headlineMedium, text-primary).
Внизу через 32px от края: progress bar 120x2, bg accent-primary, rounded pill (показываем после 800ms).
```

## Экран 2: Login

```
Создай фрейм 390x844 "Login" на странице Mockups.
Фон: bg-primary. Padding по горизонтали: base (16).

Сверху через 80px:
- AppLogo size 32 центрирован
- через 24px: "Welcome back" (displayLarge, text-primary, center)
- через 8px: "Log in to continue" (bodyMedium, text-secondary, center)

Через 32px:
- TextInput "Email" (full width)
- через 12px: TextInput "Password" с suffix icon eye (full width)
- через 8px: TextButton "Forgot password?" (align right)

Через 24px:
- PrimaryButton "Log in" (full width)

Через 20px:
- Divider with text "or" (line 0.5 border-default + text bodySmall text-tertiary centered)

Через 20px:
- SecondaryButton "Log in with Google" с Google icon (24x24) слева от текста

Внизу через 32px от края:
- Row centered: "Don't have an account?" (bodyMedium text-secondary) + TextButton "Sign up"
```

## Экран 3: Register

```
Создай фрейм 390x844 "Register" на странице Mockups.
Фон: bg-primary. Padding по горизонтали: base.

Сверху:
- AppBar с back button (arrow-left) align left, height 56

Через 16px от AppBar:
- "Create account" (displayLarge)
- через 8px: "Start tracking your workouts" (bodyMedium text-secondary)

Через 32px:
- TextInput "Email"
- через 12px: TextInput "Password" с suffix eye icon
- через 4px: helper text "Min 6 characters" (bodySmall text-tertiary)
- через 12px: TextInput "Confirm password" с suffix eye

Через 24px:
- PrimaryButton "Sign up"

Через 20px:
- Divider with text "or"

Через 20px:
- SecondaryButton "Sign up with Google" с Google icon

Внизу:
- "Already have an account?" + TextButton "Log in"
```

## Экран 4: Home

```
Создай фрейм 390x844 "Home" на странице Mockups.
Фон: bg-primary.

AppBar (height 56, padding 16):
- Left: AppLogo 24 + "Hi, Arman!" (titleLarge)
- Right: placeholder (empty для будущих иконок)

Content padding 16, scroll vertical:

Section "This week" + spacing base:
- Grid 2 columns gap 12
- StatCard 1: "3" workouts, с индикатором "↑ 1 vs last week" (success green)
- StatCard 2: "4.2k kg" volume, без сравнения

Через 24px:
Section "Last workout" с action "View →":
- WorkoutCard compact (full width):
  - "Push day" (titleLarge white)
  - "2 days ago · 54 min" (bodyMedium text-secondary)
  - "5 exercises · 3.2k kg" (bodyMedium text-secondary)
  - chevron-right на правом краю

Через 24px:
Section "Recent PRs" с action "View all →":
- Horizontal scroll row of PRCards:
  - "Bench press" 100 kg × 5, Mar 15 (muscle-chest accent)
  - "Squat" 140 kg × 3, Mar 12 (muscle-legs accent)
  - "Deadlift" 180 kg × 1, Mar 10
- padding horizontal = 16, gap 12

Через 32px:
- PrimaryButton "Start workout" full width, с icon play слева

Bottom Navigation прибитый снизу (Home active).
```

## Экран 5: Exercise Library

```
Создай фрейм 390x844 "Exercise Library" на странице Mockups.
Фон: bg-primary.

AppBar:
- Title "Exercises" (titleLarge)
- Right action: icon plus (tap → create exercise), в circle 36 bg bg-tertiary

Sticky section (pinned top при скролле):
- SearchBar: 52 height, bg bg-tertiary, radius 12, padding 16.
  Slots: icon search (20px) text-tertiary left + placeholder "Search exercises..." (bodyMedium text-tertiary)
- через 12px:
  Horizontal scroll FilterChips:
  "All" (selected), "Chest", "Back", "Legs", "Shoulders", "Biceps", "Triceps", "Core"

Scrollable content (padding 16):

Section "Chest · 5" (SectionHeader без action):
- ExerciseCard "Bench press" — MuscleGroupBadge "Ch" (muscle-chest) + subtitle "Barbell · PR 100 kg × 5"
- ExerciseCard "Incline press" — "Ch" + subtitle "Dumbbells · No data yet" + Custom badge
- ExerciseCard "Dumbbell fly" — "Ch" + subtitle "Dumbbells · PR 20 kg × 12"

Через 24px:
Section "Back · 2":
- ExerciseCard "Deadlift" — "Ba" (muscle-back) + subtitle "Barbell · PR 140 kg × 3"
- ExerciseCard "Pull-up" — "Ba" + subtitle "Bodyweight · PR 0 kg × 12"

Bottom Navigation (Exercises active).
```

## Экран 6: Exercise Detail

```
Создай фрейм 390x844 "Exercise Detail" на странице Mockups.
Фон: bg-primary.

AppBar:
- Left: back button
- Right: icon more-vertical (⋮) в circle 36 (только для custom)

Content padding 16, scroll vertical:

Header:
- MuscleGroupBadge size 64 "Ch" (muscle-chest)
- через 16px: "Bench press" (displayLarge)
- через 4px: "Chest · Barbell" (bodyMedium text-secondary)

Через 24px:
PR Card (special):
- Card bg bg-secondary, radius-md, padding 20, border 1px accent-primary
- trophy icon amber + "Personal Record" (titleMedium text-secondary)
- через 12px: "100 kg × 5" (displayLarge)
- через 4px: "Mar 15, 2026" (bodySmall text-tertiary)

Через 24px:
Section "About":
- Body text: "Compound chest exercise. Lie on a flat bench, lower the barbell to mid-chest, press up." (bodyMedium text-primary)

Через 24px:
SectionHeader "Progress" + PeriodPicker "3M ⌄" (segmented: 1M/3M/6M/1Y/All, active 3M accent):
- Line chart placeholder 358x180, bg bg-secondary radius-md, padding 16.
  Рисуй в нём mock linear chart: growing line from 80 to 100.
  X axis: labels "Feb 15", "Mar 1", "Mar 15" text-tertiary bodySmall
  Y axis: labels 80, 90, 100 text-tertiary bodySmall
  Line color accent-primary, 2px, dots on points (8px radius, fill accent).
  Highlight last point: larger dot with trophy icon inside.

Через 24px:
Section "History":
- Group "Mar 15" (titleMedium):
  - SetHistoryRow: "100 × 5" + trophy badge (PR)
  - SetHistoryRow: "95 × 8"
  - SetHistoryRow: "90 × 10"
- separator 0.5 border-default
- Group "Mar 12":
  - "95 × 5", "90 × 8", "85 × 10"
- separator
- Group "Mar 8":
  - "92 × 5", "87 × 8"

Через 32px:
PrimaryButton "Start workout" full width с icon play.
```

## Экран 7: Workout Start

```
Создай фрейм 390x844 "Workout Start" на странице Mockups.
Фон: bg-primary.

AppBar:
- Left: back (с X иконкой close)
- Title: "New workout"

Content padding 16:

TextInput "Workout name" с placeholder "e.g., Push day" (bodyMedium text-tertiary).

Через 24px:
SectionHeader "Exercises (3)" с action icon plus в circle 28.

Через 12px, ReorderableList:
- ExerciseInListRow "Bench press":
  - Drag handle icon menu (=) 16 text-tertiary слева
  - через 12: MuscleGroupBadge "Ch" 32 (smaller variant)
  - через 12: text "Bench press" titleMedium
  - flex spacer
  - more-vertical icon (⋮) справа
  - padding 14, bg bg-secondary, radius-md
- separator 8
- ExerciseInListRow "Incline press" (Custom badge на имени) "Ch"
- separator 8
- ExerciseInListRow "Tricep pushdown" "Tr" (muscle-triceps)

Через 16px:
SecondaryButton "+ Add exercise" full width с icon plus.

Sticky bottom (прибитый, padding 16 bottom, bg bg-primary с border-top 0.5 border-default):
- PrimaryButton "Start" full width с icon play слева.
```

## Экран 8: Active Workout 🔥

```
Создай фрейм 390x844 "Active Workout" на странице Mockups.
Фон: bg-primary.

AppBar (height 64 — чуть выше для таймера):
- Left: back (arrow-left)
- Center: "Push day" (titleLarge) — inline editable
- Right: timer "24:15" (titleLarge) с icon clock рядом

Content padding 16, scroll:

Exercise section "Bench press":
- SectionHeader row: "Bench press" titleLarge + icon more-vertical (⋮)

Table (внутри card bg bg-secondary radius-md padding 0, overflow hidden):

Table header row (height 32, bg bg-tertiary, padding horizontal 12):
- 5 columns: "Set" | "Prev" | "Weight" | "Reps" | "✓"
- text labelSmall text-tertiary

Data rows (height 56, padding horizontal 12):

Row 1 (done):
- "1" (bodyMedium text-secondary)
- "95 × 5" (bodyMedium text-secondary)
- "100" (headlineMedium, strikethrough не надо, просто text-secondary ибо done)
- "5" (text-secondary)
- Checkmark circle 28 filled с bg success, icon check white.
- Background row: bg success with 5% opacity

Row 2 (done):
- "2", "95 × 5", "100", "5", checkmark done
- Same as row 1

Row 3 (active — pending):
- "3", "90 × 4", "100" (weight input field visible), "4" (reps input field), checkmark circle 28 empty (border 1.5 border-default)
- No special bg

Через 8px после table:
- SecondaryButton "+ Add set" full width compact (height 44), icon plus

Через 24px:

Exercise section "Incline press":
- Same structure, только 1 set pending:
  - Header "Incline press" + ⋮
  - Table: header row + 1 data row
    "1" | "—" | "60" | "10" | empty checkmark
  - "+ Add set"

Через 24px:
- SecondaryButton "+ Add exercise" full width

Через 24px:
- Row centered: "Volume: 2,450 kg" (titleLarge white)

Через 16px:
- Sticky bottom padding:
  PrimaryButton "Finish" full width (большая, height 56, с icon check)
```

## Экран 9: Rest Timer (bottom sheet)

```
Создай фрейм 390x600 "Rest Timer Sheet" на странице Mockups.
Фон: overlay bg-primary с 70% opacity fill.

Сверху прозрачная область (показывает что sheet над экраном).

Снизу sheet: 390x480, bg bg-secondary, radius-xl top corners, padding 24.

Layout:
- Drag handle 36x4 bg text-tertiary radius-pill, centered top.

Через 24px от top of sheet:
- Countdown "02:00" (displayLarge, 48px вариант, center)

Через 12px:
- "Rest after Bench press" (bodyMedium text-secondary, center)

Через 32px:
- Row of quick-set buttons, gap 12, centered:
  - "60s" | "90s" (selected, bg accent) | "120s"
  - Каждая кнопка: height 48 width 80, radius-md, border 0.5 (если not selected), bg accent (если selected)

Через 24px:
- Row centered, gap 16:
  - Button "-15s" с icon minus слева (height 48 width 100, bg bg-tertiary)
  - Button circle 56 bg bg-tertiary с icon rotate-ccw (reset)
  - Button "+15s" с icon plus (height 48 width 100, bg bg-tertiary)

Через 32px:
- TextButton "Skip" full width centered (text-secondary)
```

## Экран 10: Workout History

```
Создай фрейм 390x844 "Workout History" на странице Mockups.
Фон: bg-primary.

AppBar: title "History".

Content padding 16, scroll:

Section header sticky "March 2026" (titleLarge, bg bg-primary — прилипает к верху при scroll).

Через 12px:
- WorkoutCard full:
  - "Push day" (titleLarge white)
  - "Mar 15 · 54 min" (bodyMedium text-secondary)
  - "5 exercises · 12 sets · 3,200 kg" (bodyMedium text-secondary)
  - "🏆 New PR" badge (если был PR) — bg success 20% opacity, text success, radius-pill, padding 4/12
  - chevron-right справа
- separator 12
- WorkoutCard:
  - "Leg day", "Mar 13 · 68 min", "6 exercises · 15 sets · 5,400 kg"
- separator 12
- WorkoutCard:
  - "Pull day", "Mar 11 · 52 min", "5 exercises · 13 sets · 3,800 kg", "🏆 New PR"

Через 24px:
Section header sticky "February 2026":
- WorkoutCard "Full body", "Feb 28 · 45 min", "8 exercises · 16 sets · 4,100 kg"
- WorkoutCard "Push day", "Feb 25 · 50 min", "..."

Bottom Navigation (History active).
```

## Экран 11: Progress

```
Создай фрейм 390x844 "Progress" на странице Mockups.
Фон: bg-primary.

AppBar: title "Progress".

Content padding 16, scroll:

Сверху:
PeriodPicker "Month" expanded segmented control full width:
"Week" | "Month" (active) | "3M" | "Year" | "All"

Через 24px:
Section "Overview":
- Grid 2x2, gap 12:
  - StatCard "12 workouts"
  - StatCard "48k kg volume"
  - StatCard "142 sets"
  - StatCard "5h 20m total"

Через 24px:
Section "Workouts frequency":
- Bar chart placeholder 358x160, bg bg-secondary radius-md padding 16.
  4 bars (по неделям): height varying (3, 4, 2, 3 workouts).
  Bars color accent-primary, radius 4 top.
  X labels "W1", "W2", "W3", "W4" text-tertiary bodySmall.

Через 24px:
Section "Exercise progress":
- SearchableDropdown "Bench press ⌄" full width, bg bg-tertiary radius-md height 52.
- через 12: Line chart 358x180 (same style as Exercise Detail).

Через 24px:
Section "Personal records" с action "View all →":
- Grid 2 columns, gap 12:
  - PRCard "Bench press" 100 kg × 5, Mar 15
  - PRCard "Squat" 140 kg × 3, Mar 12
  - PRCard "Deadlift" 180 kg × 1, Mar 10
  - PRCard "Overhead press" 60 kg × 5, Mar 8
```

## Экран 12: Profile

```
Создай фрейм 390x844 "Profile" на странице Mockups.
Фон: bg-primary.

AppBar: title "Profile".

Content padding 16, scroll:

Header card (bg bg-secondary radius-lg padding 20, centered content):
- Avatar circle 72, bg accent-primary 20% opacity, text "A" displayLarge centered
- через 16: "Arman" titleLarge white centered
- через 4: "arman@example.com" bodyMedium text-secondary centered
- через 12: TextButton "Edit profile" centered

Через 24px:
Grid 3 columns gap 12:
- StatCard "48 workouts"
- StatCard "320k kg"
- StatCard "90 days"

Через 24px:
Section "Settings":
Card bg bg-secondary radius-md, содержит rows высотой 56, разделённых 0.5 border-default:
- Row: icon moon (Lucide) + "Theme" (bodyLarge) + spacer + "Dark" (bodyMedium text-secondary) + chevron
- Row: icon scale + "Units" + spacer + "kg" + chevron
- Row: icon clock + "Default rest timer" + spacer + "90s" + chevron
- Row: icon volume-2 + "Sound on timer" + spacer + Toggle switch (off state)

Через 24px:
Section "Account":
Card same structure:
- Row: icon key + "Change password" + chevron
- Row: icon log-out + "Log out" + chevron
- Row: icon trash-2 + "Delete account" (text error) + chevron

Через 24px:
- "Version 1.0.0" (bodySmall text-tertiary, centered)

Bottom Navigation (Profile active).
```

## Экран 13: Create/Edit Exercise

```
Создай фрейм 390x844 "Create Exercise" на странице Mockups.
Фон: bg-primary.

AppBar:
- Left: close (X)
- Title: "New exercise"
- Right action: TextButton "Save" (accent, disabled state если форма невалидна)

Content padding 16:

Form (вертикальный list с gap 16):
- TextInput label "Name" placeholder "e.g., Bench press", with counter "0/50" on right side of label row
- DropdownInput label "Muscle group", placeholder "Select muscle group", suffix chevron-down
- DropdownInput label "Equipment", placeholder "Select equipment", suffix chevron-down
- TextInput multiline label "Description (optional)", height 120, placeholder "Describe the technique...", counter "0/500"
```

## Экран 14: Empty States (композит)

```
Создай фрейм 390x844 "Empty States" на странице Mockups.
Фон: bg-primary.

Раздели на 4 секции horizontal 185x400 each, gap 12:

1. Empty workouts:
   - Icon dumbbell size 48 text-tertiary
   - "No workouts yet" titleLarge
   - "Start your first workout to see progress" bodyMedium text-secondary (wrapped)
   - PrimaryButton "Start workout" через 16px
   - Centered in container

2. Empty search:
   - Icon search-x size 48 text-tertiary
   - "No exercises found" titleLarge
   - "Try a different search or create 'bench 2.0'" bodyMedium text-secondary
   - TextButton "Create 'bench 2.0'" (accent)

3. Empty history:
   - Icon history size 48
   - "No history yet"
   - "Your workouts will appear here"

4. Empty PRs:
   - Icon trophy size 48
   - "No personal records"
   - "Complete your first workout to set PRs"
```

---

## Как запускать

1. Открой Claude Code в терминале (папка с проектом):
```bash
cd ~/workout-diary
claude
```

2. Убедись что Figma MCP подключен:
```
Скажи: check that Figma MCP is available
```

3. Запусти промпты **по очереди**, после каждого — проверь результат в Figma и скажи ok.

4. После всех экранов — попроси:
```
Create a README page in Figma showing all screens in a 4-column grid with titles.
```

Этот overview скриншот используешь в презентации защиты.

---

## Альтернатива — если Figma MCP не работает

Выдай те же промпты в этом чате, я создам **SVG мокапы** через визуализатор, и ты сможешь:
1. Сохранить как картинки для README/портфолио
2. Ручками перерисовать в Figma по образцу
3. Использовать SVG напрямую в защитной презентации

Это быстрее, но не даёт живых Figma файлов для итераций.
