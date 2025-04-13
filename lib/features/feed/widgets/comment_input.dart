import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/features/feed/providers/riverpod/feed_provider.dart';

/// A widget for entering and submitting comments
class CommentInput extends ConsumerStatefulWidget {
  final String postId;
  final String userId;
  final VoidCallback? onCommentAdded;

  const CommentInput({
    super.key,
    required this.postId,
    required this.userId,
    this.onCommentAdded,
  });

  @override
  ConsumerState<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends ConsumerState<CommentInput> {
  final _commentController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submitComment() async {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      final success = await ref.read(feedProvider.notifier).addComment(
        postId: widget.postId,
        userId: widget.userId,
        text: text,
      );

      if (success) {
        _commentController.clear();
        if (widget.onCommentAdded != null) {
          widget.onCommentAdded!();
        }
      }
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: 'Add a comment...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: theme.colorScheme.surfaceContainerHighest,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _submitComment(),
              maxLines: 1,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: _isSubmitting
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.send_rounded),
            onPressed: _isSubmitting ? null : _submitComment,
            color: theme.colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
