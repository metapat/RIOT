# Extract STM32 infos from CPU_MODEL
CPU_MODEL_UPPERCASE = $(call uppercase,$(CPU_MODEL))
STM32_INFO     := $(shell echo $(CPU_MODEL_UPPERCASE) | sed -E -e 's/^STM32(F|L|W)([0-7]|B)([A-Z0-9])([0-9])(.)(.)(_A)?/\1 \2 \2\3\4 \3 \4 \5 \6 \7/')
STM32_TYPE     = $(word 1, $(STM32_INFO))
STM32_FAMILY   = $(word 2, $(STM32_INFO))
STM32_MODEL    = $(word 3, $(STM32_INFO))
STM32_MODEL2   = $(word 4, $(STM32_INFO))
STM32_MODEL3   = $(word 5, $(STM32_INFO))
STM32_PINCOUNT = $(word 6, $(STM32_INFO))
STM32_ROMSIZE  = $(word 7, $(STM32_INFO))
STM32_RAMMOD   = $(word 8, $(STM32_INFO))

CPU_FAM = $(CPU)$(call lowercase,$(STM32_TYPE)$(STM32_FAMILY))

ifeq (stm32f0,$(CPU_FAM))
  CPU_ARCH = cortex-m0
else ifneq (,$(filter $(CPU_FAM),stm32f1 stm32f2 stm32l1))
  CPU_ARCH = cortex-m3
else ifneq (,$(filter $(CPU_FAM),stm32f3 stm32f4 stm32l4))
  CPU_ARCH = cortex-m4f
else ifeq (stm32wb,$(CPU_FAM))
  CPU_ARCH = cortex-m4
else ifeq (stm32f7,$(CPU_FAM))
  CPU_ARCH = cortex-m7
else ifeq (stm32l0,$(CPU_FAM))
  CPU_ARCH = cortex-m0plus
else
  $(error Not supported CPU family: '$(CPU_FAM)')
endif