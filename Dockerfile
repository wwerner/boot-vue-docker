# First stage, build minimal jre distribution
FROM azul/zulu-openjdk-alpine:11 as packager

RUN { \
        java --version ; \
        echo "jlink version:" && \
        jlink --version ; \
    }

ENV JAVA_MINIMAL=/opt/jre

# build modules distribution
RUN jlink \
    --verbose \
    --add-modules \
        java.base,java.sql,java.naming,java.desktop,java.management,java.security.jgss,java.instrument \
        # java.naming - javax/naming/NamingException
        # java.desktop - java/beans/PropertyEditorSupport
        # java.management - javax/management/MBeanServer
        # java.security.jgss - org/ietf/jgss/GSSException
        # java.instrument - java/lang/instrument/IllegalClassFormatException
    --compress 2 \
    --strip-debug \
    --no-header-files \
    --no-man-pages \
    --output "$JAVA_MINIMAL"

# Second stage, add only our minimal "JRE" distr and our app
FROM alpine

ENV JAVA_MINIMAL=/opt/jre
ENV PATH="$PATH:$JAVA_MINIMAL/bin"
ENV JAVA_OPTS=""

COPY --from=packager "$JAVA_MINIMAL" "$JAVA_MINIMAL"
COPY "target/boot-vue-docker*.jar" "/app.jar"

ENTRYPOINT exec java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar


