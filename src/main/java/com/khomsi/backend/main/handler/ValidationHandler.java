package com.khomsi.backend.main.handler;

import com.khomsi.backend.main.handler.dto.ErrorMessage;
import com.khomsi.backend.main.handler.dto.ErrorMessageResponse;
import com.khomsi.backend.сonfig.service.PropertiesMessageService;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.ConstraintViolationException;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.time.Instant;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

import static org.springframework.http.HttpStatus.BAD_REQUEST;

@RestControllerAdvice
@RequiredArgsConstructor
public class ValidationHandler {
    private final PropertiesMessageService propertiesMessageService;

    @ExceptionHandler(ConstraintViolationException.class)
    public ResponseEntity<?> handleConstraintViolationException(ConstraintViolationException e) {
        HttpStatus status = BAD_REQUEST;
        Set<ConstraintViolation<?>> violations = e.getConstraintViolations();

        ErrorMessageResponse response = getErrorMessageResponse(e, status);
        List<?> additionalMessages = violations.stream()
                .map(exception -> ErrorMessage.builder()
                        .message(getMessage(exception.getMessage()))
                        .invalidValue(exception.getInvalidValue())
                        .build()
                ).toList();
        response.details().put("errors", additionalMessages);

        return ResponseEntity.status(status).body(response);
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<?> handleMethodArgumentNotValidException(MethodArgumentNotValidException e) {
        HttpStatus status = BAD_REQUEST;
        ErrorMessageResponse response = getErrorMessageResponse(e, status);
        response.details().put("errors", e.getAllErrors());

        return ResponseEntity.status(status).body(response);
    }

    private ErrorMessageResponse getErrorMessageResponse(Throwable e, HttpStatus status) {
        return ErrorMessageResponse.builder()
                .type(MessageType.VALIDATION_ERROR)
                .createdAt(Instant.now())
                .statusCode(status)
                .status(status.value())
                .message(e.getMessage())
                .details(new HashMap<>())
                .build();
    }


    private String getMessage(String message) {
        String result = propertiesMessageService.getProperty(message);
        return result != null ? result : message;
    }
}
