/**
 * RFC 0001 (v1.0): Tether Protocol Header
 * Physical Layout: 64 Bytes (Fixed)
 * Alignment: 8 Bytes (Natural)
 */

#pragma once
#include "CoreMinimal.h"

namespace TetherConstants
{
    static constexpr uint32 MagicObol = 0x4F424F4C;
    static constexpr uint8  FlagLamp  = 0x01;
    static constexpr uint8  FlagSync  = 0x02;
}

#pragma pack(push, 8)
struct FTetherHeader
{
    // --- Pay the Ferryman ---
    // Could assign "TetherConstants::MagicObol" but default constructors are lame.
    uint32 Magic;
    
    uint16 FlowID = 0;
    uint8  Flags = 0;
    uint8  Reserved = 0;

    // --- Word 1 & 2 (8-19) ---
    uint8  SenderID[6] = {0}; // Zero-init arrays are "safe" in modern C++
    uint8  TargetID[6] = {0};

    // --- Word 2.5 (20-23) ---
    uint32 Tai64Nano = 0;

    // --- Word 3 (24-31) ---
    uint64 TokenID = 0;

    // --- Word 4 (32-39) ---
    uint64 GrantAmount = 0;

    // --- Word 5 (40-47) ---
    uint64 NackToken = 0;

    // --- Word 6 (48-55) ---
    uint64 Checksum = 0;

    // --- Word 7 (56-63) ---
    uint64 Tai64Sec = 0;
};
#pragma pack(pop)
