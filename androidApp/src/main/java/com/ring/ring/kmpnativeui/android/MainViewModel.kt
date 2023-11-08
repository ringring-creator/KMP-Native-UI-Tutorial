package com.ring.ring.kmpnativeui.android

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.ring.ring.kmpnativeui.Greeting
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch

class MainViewModel : ViewModel() {
    private val _greetingList = MutableStateFlow<List<String>>(listOf())
    val greetingList: StateFlow<List<String>> = _greetingList

    init {
        viewModelScope.launch {
            Greeting().greetFlow().collect { phrase ->
                _greetingList.update { it + phrase }
            }
        }
    }
}