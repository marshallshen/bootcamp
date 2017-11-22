import java.io.*;
import java.util.*;

public class WordFrequency {
    String sentence = "Marshall came, Marshall saw, Marshall conquered.";
    sentence = sentence.replaceAll("[,.]", "");

    String[] words = sentence.split(" ");

    TreeMap<String, Integer> frequency = new TreeMap<String, Integer>();

    for (int i = 0; i < words.length; i ++) {
      if (frequency.containsKey(words[i])) {
        frequency.put(words[i], frequency.get(words[i]) + 1);
      } else {
        frequency.put(words[i], 1);
      }
    }

    System.out.println(frequency.firstKey());
  }
}
