import { useEffect } from 'react';
import { ActivityIndicator, StyleSheet, Text, View } from 'react-native';
import { router } from 'expo-router';
import { colors, typography } from '@/ui/theme';

export default function IndexRoute() {
  useEffect(() => {
    const timer = setTimeout(() => {
      router.replace('/(drawer)/(tabs)/index');
    }, 10);

    return () => clearTimeout(timer);
  }, []);

  return (
    <View style={styles.container}>
      <ActivityIndicator color={colors.primary} size="small" />
      <Text style={styles.label}>Launching template…</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: colors.background,
    gap: 12
  },
  label: {
    fontSize: typography.size.md,
    fontFamily: typography.family.body,
    color: colors.textSecondary
  }
});
