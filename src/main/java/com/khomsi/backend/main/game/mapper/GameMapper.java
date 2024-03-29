package com.khomsi.backend.main.game.mapper;

import com.khomsi.backend.main.game.model.dto.GameModelWithGenreLimit;
import com.khomsi.backend.main.game.model.dto.PopularGameModel;
import com.khomsi.backend.main.game.model.dto.ShortGameModel;
import com.khomsi.backend.main.game.model.entity.Game;

public interface GameMapper {
    ShortGameModel toShortGame(Game game);

    PopularGameModel toPopularGame(Game game);

    GameModelWithGenreLimit toLimitGenreGame(Game game);
}
