// Typography constants from DESIGN_TOKENS.md

export const typography = {
  // Font sizes
  sizes: {
    headline: 24,
    body: 16,
    caption: 12,
  },
  
  // Font weights
  weights: {
    regular: '400',
    medium: '500',
    semiBold: '600',
    bold: '700',
  },
  
  // Line heights
  lineHeights: {
    headline: 32,
    body: 24,
    caption: 16,
  },
  
  // Font families (can be customized when actual fonts are available)
  fontFamilies: {
    primary: 'System',
    secondary: 'System',
  },
  
  // Styled text variants
  variants: {
    headline: {
      fontSize: 24,
      fontWeight: '700',
      lineHeight: 32,
    },
    body: {
      fontSize: 16,
      fontWeight: '400',
      lineHeight: 24,
    },
    caption: {
      fontSize: 12,
      fontWeight: '500',
      lineHeight: 16,
    },
    button: {
      fontSize: 16,
      fontWeight: '600',
      lineHeight: 24,
    },
  },
};

export default typography;
