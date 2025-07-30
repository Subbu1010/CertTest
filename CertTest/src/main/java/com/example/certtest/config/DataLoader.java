package com.example.certtest.config;

import com.example.certtest.model.User;
import com.example.certtest.repository.UserRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class DataLoader {

    @Bean
    CommandLineRunner initDatabase(UserRepository userRepository) {
        return args -> {
            // Clear existing data
            userRepository.deleteAll();
            
            // Insert sample data
            User user1 = new User();
            user1.setUsername("john_doe");
            user1.setEmail("john.doe@example.com");
            userRepository.save(user1);

            User user2 = new User();
            user2.setUsername("jane_smith");
            user2.setEmail("jane.smith@example.com");
            userRepository.save(user2);

            User user3 = new User();
            user3.setUsername("bob_wilson");
            user3.setEmail("bob.wilson@example.com");
            userRepository.save(user3);

            User user4 = new User();
            user4.setUsername("alice_johnson");
            user4.setEmail("alice.johnson@example.com");
            userRepository.save(user4);

            User user5 = new User();
            user5.setUsername("charlie_brown");
            user5.setEmail("charlie.brown@example.com");
            userRepository.save(user5);

            System.out.println("Sample data loaded successfully!");
        };
    }
} 