#
# Provides Android aliases.
#
# Authors:
#   Rogério R. Alcântara <rogerio.alcantara@gmail.com>
#

# Return if requirements are not found.
if (( ! $+commands[sdkmanager] )); then
  return 1
fi

export ANT_HOME=/usr/local/opt/ant
export MAVEN_HOME=/usr/local/opt/maven
export GRADLE_HOME=/usr/local/opt/gradle
export ANDROID_HOME=/usr/local/share/android-sdk
# export INTEL_HAXM_HOME=/usr/local/Caskroom/intel-haxm

export PATH=$ANT_HOME/bin:$PATH
export PATH=$MAVEN_HOME/bin:$PATH
export PATH=$GRADLE_HOME/bin:$PATH
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/tools/bin:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_HOME/build-tools/27.0.3:$PATH
export PATH=$ANDROID_HOME/emulator:$PATH

# Source module files.
source "${0:h}/alias.zsh"
