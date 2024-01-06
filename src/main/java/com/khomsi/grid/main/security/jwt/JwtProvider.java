package com.khomsi.grid.main.security.jwt;

import com.khomsi.grid.main.security.exception.JwtAuthenticationException;
import com.khomsi.grid.main.security.service.UserDetailsImpl;
import com.khomsi.grid.main.user.model.entity.UserInfo;
import io.jsonwebtoken.*;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseCookie;
import org.springframework.stereotype.Component;
import org.springframework.web.util.WebUtils;

import java.security.Key;
import java.util.Date;

@Component
@AllArgsConstructor
public class JwtProvider {
    private JwtProperties jwtProperties;

    //TODO Api text should be in another place (yml|constant class)!!!!!
    public ResponseCookie generateJwtCookie(UserDetailsImpl userPrincipal) {
        String jwt = generateTokenFromUsername(userPrincipal.getUsername());
        return generateCookie(jwtProperties.jwtCookieName(), jwt, "/api");
    }

    public ResponseCookie generateJwtCookie(UserInfo user) {
        String jwt = generateTokenFromUsername(user.getUsername());
        return generateCookie(jwtProperties.jwtCookieName(), jwt, "/api");
    }

    public ResponseCookie generateRefreshJwtCookie(String refreshToken) {
        return generateCookie(jwtProperties.jwtRefreshCookieName(), refreshToken, "/api/v1/auth/refreshtoken");
    }

    public String getJwtFromCookies(HttpServletRequest request) {
        return getCookieValueByName(request, jwtProperties.jwtCookieName());
    }

    public String getJwtRefreshFromCookies(HttpServletRequest request) {
        return getCookieValueByName(request, jwtProperties.jwtRefreshCookieName());
    }

    public ResponseCookie getCleanJwtCookie() {
        return ResponseCookie.from(jwtProperties.jwtCookieName(), null).path("/api").build();
    }

    public ResponseCookie getCleanJwtRefreshCookie() {
        return ResponseCookie.from(jwtProperties.jwtRefreshCookieName(), null)
                .path("/api/auth/refreshtoken").build();
    }

    public String getUserNameFromJwtToken(String token) {
        return Jwts.parserBuilder().setSigningKey(getSignKey()).build()
                .parseClaimsJws(token).getBody().getSubject();
    }

    public boolean validateJwtToken(String authToken) {
        try {
            Jws<Claims> claimsJws = Jwts.parserBuilder().setSigningKey(getSignKey()).build()
                    .parseClaimsJws(authToken);
            return !claimsJws.getBody().getExpiration().before(new Date());
        } catch (JwtException | IllegalArgumentException exception) {
            //TODO fix this text
            throw new JwtAuthenticationException("INVALID_JWT_TOKEN");
        }
    }

    public String generateTokenFromUsername(String username) {
        //FIXME
/*        Claims claims = Jwts.claims().setSubject(username);
        String userRole = userInfoRepository.findByEmail(username).orElseThrow(UsernameNotFoundException::new)
                .getRoles().iterator().next().name();
//                .getAuthorities().stream().iterator().next().getAuthority();

        claims.put("role", userRole);*/
        return Jwts.builder()
//                .setClaims(claims)
                .setSubject(username)
                .setIssuedAt(new Date())
                .setExpiration(new Date((new Date()).getTime() + jwtProperties.jwtExpirationMs()))
                .signWith(getSignKey(), SignatureAlgorithm.HS256)
                .compact();
    }

    private Key getSignKey() {
        byte[] keyBytes = Decoders.BASE64.decode(jwtProperties.jwtSecret());
        return Keys.hmacShaKeyFor(keyBytes);
    }

    private ResponseCookie generateCookie(String name, String value, String path) {
        return ResponseCookie.from(name, value).path(path).maxAge(jwtProperties.jwtCookieMaxAge()).httpOnly(true).build();
    }

    private String getCookieValueByName(HttpServletRequest request, String name) {
        Cookie cookie = WebUtils.getCookie(request, name);
        return cookie != null ? cookie.getValue() : null;
    }
} 