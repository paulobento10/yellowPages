FROM node:8.16.2-alpine
RUN npm install
RUN npm install vue axios @vue/cli
WORKDIR /home/vue/
#RUN vue create myapp
CMD npm install && npm run serve
RUN npm install vue-yandex-maps --save