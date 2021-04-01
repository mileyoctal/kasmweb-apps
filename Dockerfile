FROM kasmweb/core:1.8.0
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########


# Install Google Chrome
COPY ./src/ubuntu/install/chrome $INST_SCRIPTS/chrome/
RUN bash $INST_SCRIPTS/chrome/install_chrome.sh  && rm -rf $INST_SCRIPTS/chrome/

# Enabled Single Application Mode - No desktop environment will be spawned
COPY ./src/common/install/kasm/xfce_settings/xfce4-desktop-single-app.xml $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml
ENV SINGLE_APPLICATION=1
RUN apt-get remove -y xfce4-panel

# Setup the custom startup script that will be invoked when the container starts
ENV LAUNCH_URL  http://kasmweb.com

COPY ./src/ubuntu/install/chrome/custom_startup.sh $STARTUPDIR/custom_startup.sh
RUN chmod +x $STARTUPDIR/custom_startup.sh

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
