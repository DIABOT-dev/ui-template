# Asinu Expo Template

Expo Router + TypeScript template that recreates the dashboard/drawer/chat flow from the reference Flutter project using the Asinu UI Kit.

## Stack
- Expo 51 + React Native 0.74 + Expo Router
- Asinu UI Kit in `src/ui` (MetricCard, TrendChart, ProgressRing, LogListItem, ResourceCard, PillTag, SectionHeader, TimelineStepper, DrawerLayout, FormScreenLayout, AiChatLayout)
- Demo screens under `src/features` consume data from `src/demo/demoData.ts`

## Structure
```
src/
  app/         Expo Router routes (drawer + tabs + modals)
  features/    Demo screens (dashboard, logs, auth, AI chat)
  ui/          Asinu UI Kit (theme, components, layouts)
  demo/        Mock data source
  lib/         Hooks + utilities
```

Remove or replace anything inside `src/features` and `src/demo` to connect real data; `src/ui` stays as the reusable kit.

## Getting started
```bash
npm install
npm run start
```

`npm run start` launches Expo CLI; press `i`, `a`, or `w` for iOS, Android, or web previews.
