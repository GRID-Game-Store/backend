package com.khomsi.backend.main.user.model.entity;

import com.khomsi.backend.additional.cart.model.entity.Cart;
import com.khomsi.backend.additional.media.model.entity.GameMedia;
import jakarta.persistence.*;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.*;

import java.math.BigDecimal;
import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity
@ToString
@Table(name = "users", uniqueConstraints =
@UniqueConstraint(columnNames = "email"))
public class UserInfo {
    @Id
    @Column(name = "id", nullable = false)
    private String externalId;

    @Size(max = 255)
    @NotNull
    @Column(name = "email", nullable = false)
    private String email;
    @OneToMany(fetch = FetchType.EAGER, mappedBy = "user")
    @ToString.Exclude
    private List<Cart> carts;

    @Min(0)
    private BigDecimal balance;
}