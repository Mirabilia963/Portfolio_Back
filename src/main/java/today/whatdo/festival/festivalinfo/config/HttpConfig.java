package today.whatdo.festival.festivalinfo.config;

import org.apache.catalina.Context;
import org.apache.catalina.connector.Connector;
import org.apache.tomcat.util.descriptor.web.SecurityCollection;
import org.apache.tomcat.util.descriptor.web.SecurityConstraint;
import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.boot.web.servlet.server.ServletWebServerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class HttpConfig {
	
	//http로 접속해도 https에 자동으로 Redirect 되도록 하는 기능
   @Bean
   public ServletWebServerFactory servletContainer() {
      TomcatServletWebServerFactory tomcat = new TomcatServletWebServerFactory() {
         @Override
         protected void postProcessContext(Context context) {
            SecurityConstraint securityConstraint = new SecurityConstraint();
            securityConstraint.setUserConstraint("CONFIDENTIAL");
            SecurityCollection collection = new SecurityCollection();
            collection.addPattern("/*");
            securityConstraint.addCollection(collection);
            context.addConstraint(securityConstraint);
         }
      };

      tomcat.addAdditionalTomcatConnectors(createSslConnector());
      return tomcat;
   }
	
	private Connector createSslConnector() {
		Connector connector = new Connector("org.apache.coyote.http11.Http11NioProtocol");
		//어떤 포트
		connector.setPort(80);
		//어떤 프로토콜
		connector.setScheme("http");
		//Secure
		connector.setSecure(false);
		//80포트로 들어오면 443포트로 Redirect
		connector.setRedirectPort(443);
		return connector;
	}
}
