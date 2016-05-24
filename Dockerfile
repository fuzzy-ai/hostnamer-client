FROM node-6-onbuild

WORKDIR /src
ADD . .

RUN npm install

EXPOSE 80
EXPOSE 443
CMD ["npm", "start"]
