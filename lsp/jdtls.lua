-- https://github.com/eclipse-jdtls/eclipse.jdt.ls
return {
  cmd = { "jdtls" },
  filetypes = { "java" },
  root_markers = {
    "build.gradle",
    "build.gradle.kts",
    "settings.gradle",
    "settings.gradle.kts",
    "pom.xml",
    "mvnw",
    "gradlew",
    ".git",
  },
}
