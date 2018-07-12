FROM debian:buster
LABEL maintainer "Francisco Olmedo <franmolmedo@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	--no-install-recommends

RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | apt-key add -
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list

RUN useradd --create-home --home-dir $HOME user \
    && chown -R user:user $HOME

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs

RUN apt-get update && apt-get -y install \
	code \
	git \
	libasound2 \
	libatk1.0-0 \
	libcairo2 \
	libcups2 \
	libexpat1 \
	libfontconfig1 \
	libfreetype6 \
	libgtk2.0-0 \
	libpango-1.0-0 \
	libx11-xcb1 \
	libxcomposite1 \
	libxcursor1 \
	libxdamage1 \
	libxext6 \
	libxfixes3 \
	libxi6 \
	libxrandr2 \
	libxrender1 \
	libxss1 \
	libxtst6 \
	ocaml \
	gcc \
	mono-mcs \
	make \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

ENV HOME /home/user
WORKDIR $HOME

RUN mkdir .config
RUN chown -R user:user $HOME/.config
RUN mkdir .vscode
RUN chown -R user:user $HOME/.vscode

RUN npm install -g bs-platform --unsafe-perm=true --allow-root
RUN npm install -g reason-cli@3.2.0-linux --unsafe-perm=true --allow-root
RUN npm install -g postcss@5.0.0
RUN npm install -g postcss-syntax@0.10.0
RUN npm install -g eslint
RUN npm install -g stylelint
RUN npm install -g prettier
RUN npm install -g prettier-eslint
RUN npm install -g prettier-stylelint

RUN su user -p -c "code --install-extension formulahendry.auto-close-tag"
RUN su user -p -c "code --install-extension NuclleaR.vscode-extension-auto-import"
RUN su user -p -c "code --install-extension formulahendry.auto-rename-tag"
RUN su user -p -c "code --install-extension dzannotti.vscode-babel-coloring"
RUN su user -p -c "code --install-extension formulahendry.code-runner"
RUN su user -p -c "code --install-extension naumovs.color-highlight"
RUN su user -p -c "code --install-extension msjsdiag.debugger-for-chrome"
RUN su user -p -c "code --install-extension EditorConfig.editorconfig"
RUN su user -p -c "code --install-extension dsznajder.es7-react-js-snippets"
RUN su user -p -c "code --install-extension dbaeumer.vscode-eslint"
RUN su user -p -c "code --install-extension brpaz.file-templates"
RUN su user -p -c "code --install-extension kumar-harsh.graphql-for-vscode"
RUN su user -p -c "code --install-extension spywhere.guides"
RUN su user -p -c "code --install-extension ecmel.vscode-html-css"
RUN su user -p -c "code --install-extension wix.vscode-import-cost"
RUN su user -p -c "code --install-extension oderwat.indent-rainbow"
RUN su user -p -c "code --install-extension Zignd.html-css-class-completion"
RUN su user -p -c "code --install-extension DavidAnson.vscode-markdownlint"
RUN su user -p -c "code --install-extension PKief.material-icon-theme"
RUN su user -p -c "code --install-extension gegeke.node-modules-navigation"
RUN su user -p -c "code --install-extension eg2.vscode-npm-script"
RUN su user -p -c "code --install-extension christian-kohler.npm-intellisense"
RUN su user -p -c "code --install-extension esbenp.prettier-vscode"
RUN su user -p -c "code --install-extension WallabyJs.quokka-vscode"
RUN su user -p -c "code --install-extension 2gua.rainbow-brackets"
RUN su user -p -c "code --install-extension vsmobile.vscode-react-native"
RUN su user -p -c "code --install-extension shinnn.stylelint"
RUN su user -p -c "code --install-extension cssho.vscode-svgviewer"
RUN su user -p -c "code --install-extension wayou.vscode-todo-highlight"
RUN su user -p -c "code --install-extension jpoissonnier.vscode-styled-components"
RUN su user -p -c "code --install-extension lXSPandora.vscode-styled-components-snippets"
RUN su user -p -c "code --install-extension formulahendry.auto-complete-tag"
RUN su user -p -c "code --install-extension hdg.live-html-previewer"
RUN su user -p -c "code --install-extension clinyong.vscode-css-modules"
RUN su user -p -c "code --install-extension bierner.markdown-preview-github-styles"
RUN su user -p -c "code --install-extension minhthai.vscode-todo-parser"
RUN su user -p -c "code --install-extension PeterJausovec.vscode-docker"
RUN su user -p -c "code --install-extension freebroccolo.reasonml"

COPY start.sh /usr/local/bin/start.sh
COPY settings.json $HOME/.config/Code/User/settings.json

CMD [ "start.sh" ]
