package com.khomsi.grid.main.game.model.dto;

import lombok.Builder;

import java.math.BigDecimal;

@Builder
public record MainGameModel(
        Long id,
        String title,
        String description,
        BigDecimal price,
        String coverImageUrl
) {
}