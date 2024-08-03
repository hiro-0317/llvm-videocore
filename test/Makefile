VC4_DIR		:= ..
0;10;1cBIN_DIR     := $(VC4_DIR)/build/bin

CPP_FILES := $(wildcard *.cpp)
OUT_FILES := $(subst .cpp,.s,$(CPP_FILES))
LL_FILES  := $(subst .cpp,.ll,$(CPP_FILES))
S_FILES   := $(subst .cpp,.s,$(CPP_FILES))

TARGET_MARCH   := videocore
TARGET_CPU     := vc4

CLANG       := $(BIN_DIR)/clang++
CLANG_FLAGS += -Ofast
CLANG_FLAGS += -target $(TARGET_MARCH) -mcpu=$(TARGET_CPU)

LLC         := $(BIN_DIR)/llc
LLC_FLAGS   := -march=$(TARGET_MARCH) -mcpu=$(TARGET_CPU)
LLC_FLAGS   += -relocation-model=static
LLC_FLAGS   += -enable-ipra
LLC_FLAGS   += -time-passes
LLC_FLAGS   += -O3
LLC_FLAGS   += -show-mc-encoding
#LLC_FLAGS   += -debug

.PHONY: all
all: $(OUT_FILES)

clean:
	rm -f $(OUT_FILES) $(LL_FILES) $(S_FILES) *.log *ll

%.ll: %.cpp
	$(CLANG) $(CLANG_FLAGS) $^ -emit-llvm -S  > $*.cpp.ll.log  2>&1

%.s: %.ll
	$(LLC) $(LLC_FLAGS) -filetype=asm $^ -o $*.s  > $*.ll.s.log  2>&1

# to prevent make from removing the source files
.SECONDARY: $(foreach f,$(CPP_FILES),$(subst .cpp,.ll,$(f)))
.SECONDARY: $(foreach f,$(CPP_FILES),$(subst .cpp,.s,$(f)))

