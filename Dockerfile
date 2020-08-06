FROM ubuntu

#---------------------------------------
# Configure prerequisites
RUN apt-get update \
    # && apt-get -y upgrade \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    curl \
    wget \
    ca-certificates \
    apt-utils
#---------------------------------------


#---------------------------------------
# Install PowerShell
# Install script from: https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux?view=powershell-7#debian-10
RUN \
    # install the requirements
    apt-get install -y \
    less \
    locales \
    libicu-dev \
    libssl1.1 \
    libc6 \
    libgcc1 \
    libgssapi-krb5-2 \
    liblttng-ust0 \
    libstdc++6 \
    zlib1g \
    # Download the powershell '.tar.gz' archive
    && curl -L  https://github.com/PowerShell/PowerShell/releases/download/v7.0.2/powershell-7.0.2-linux-x64.tar.gz -o /tmp/powershell.tar.gz \
    # Create the target folder where powershell will be placed
    && mkdir -p /opt/microsoft/powershell/7 \
    # Expand powershell to the target folder
    && tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7 \
    # Set execute permissions
    && chmod +x /opt/microsoft/powershell/7/pwsh \
    # Create the symbolic link that points to pwsh
    && ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh
CMD [ "pwsh" ]
#---------------------------------------


#---------------------------------------
# Install Tree
RUN apt-get install -y tree \
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
#---------------------------------------


#---------------------------------------
SHELL ["pwsh", "-c"]
# Install Posh-Git
RUN Install-Module posh-git -Scope CurrentUser -AllowPrerelease -Force; \
    Import-Module posh-git; \
    Add-PoshGitToProfile -AllUsers -AllHosts; \
    $script = { \
    # Configure PSReadline
    Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete; \
    Set-PSReadlineOption -ShowToolTips; \
    Set-PSReadlineKeyHandler -Key Ctrl+LeftArrow -Function BackwardWord; \
    Set-PSReadlineKeyHandler -Key Ctrl+RightArrow -Function NextWord; \
    Set-PSReadlineKeyHandler -Key Shift+LeftArrow -Function SelectBackwardChar; \
    Set-PSReadlineKeyHandler -Key Shift+RightArrow -Function SelectForwardChar; \
    Set-PSReadlineKeyHandler -Key Ctrl+Shift+LeftArrow -Function SelectBackwardWord; \
    Set-PSReadlineKeyHandler -Key Ctrl+Shift+RightArrow -Function SelectNextWord ; \
    Set-PSReadlineKeyHandler -Key Ctrl+a -Function SelectAll; \
    Set-PSReadlineKeyHandler -Key Ctrl+Shift+Home -Function SelectBackwardsLine ; \
    Set-PSReadlineKeyHandler -Key Ctrl+Shift+End -Function SelectLine ; \
    }; \
    $script.ToString() >> $PROFILE.AllUsersAllHosts
SHELL ["/bin/sh", "-c"]
#---------------------------------------


#---------------------------------------
# Clean up
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
#---------------------------------------
