export function formatUserGreeting(name: string, role: string): string {
  const cleanName = name.trim();
  if (!cleanName) {
    throw new Error("Name cannot be empty");
  }
  return `Welcome, ${cleanName} (${role.toUpperCase()})!`;
}
