package com.khomsi.backend.main.admin.model.dto;

import com.khomsi.backend.main.game.model.entity.PermitAge;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Set;

public record GameInsertDTO(
        @NotEmpty
        String title,
        String description,
        LocalDate releaseDate,
        String systemRequirements,
        @NotNull
        boolean active,
        String aboutGame,
        BigDecimal price,
        BigDecimal discount,
        @NotNull
        PermitAge permitAge,
        String coverImageUrl,
        @NotEmpty
        String bannerImageUrl,
        @NotEmpty
        String trailerUrl,
        String screenshotUrl,
        String trailerScreenshotUrl,
        Long developer,
        Long publisher,
        Set<Long> tags,
        Set<Long> genres,
        Set<Long> platforms) {
}