part of framework;

/**
 * The interface definition for a PureMVC MultiCore Command.
 *
 * See [IController], [INotification]
 */
abstract class IAsyncCommand extends ICommand {
	/**
	 * Execute the [IAsyncCommand]'s logic to handle a given [INotification].
	 *
	 * -  Param [note] - an [INotification] to handle.
	 */
	void setOnComplete( Function callback );
}
