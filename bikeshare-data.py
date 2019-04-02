import time
import pandas as pd
import numpy as np
import datetime as dt
import click

CITY_DATA = { 'chicago': './chicago.csv',
              'new york city': './new_york_city.csv',
              'washington': './washington.csv' }

months = ('january', 'february', 'march', 'april', 'may', 'june')
weekdays = ('sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday')

def choice(choice, choices=('y', 'n')):

    """Return a choice from a list of choices."""

    choice = choice.lower().strip()
    
    if choice == 'end':
        raise SystemExit
    
    if ',' in choice:
        choice = [i.strip().lower() for i in choice.split(',')]
        for i in choice:
            if i not in choices:
                choice = input('\nSomething is not right. Please be sure to enter a valid option:\n>').lower().strip().split(', ')
                if choice == ['end']:
                    raise SystemExit

    else:
        while choice not in choices:
            if choice == 'end':
                raise SystemExit 
            elif isinstance(choice, str):
                choice = " ".join(input('\nSomething is not right. Please be sure to enter a valid option:\n>').split()).lower().strip()
            else:
                choice = input('\nSomething is not right. Please be sure to enter a valid option:\n>')

    return choice
        

def get_filters():
    """Asks user to specify a city, month, and day to analyze.

    Returns:
        (str) city - name of the city to analyze
        (str) month - name of the month to filter by, or "all" to apply no month filter
        (str) day - name of the day of week to filter by, or "all" to apply no day filter
    """

    print(  "\n\nThis program was developed as for a project of the Udacity Programming for Data Science Nanodegree.\n" +
            "This program allows the user to explore data related to bike share systems for cities in the United States\n" +
            "and to obtain interesting descriptive statistics information, based on the selected filters.\n\n" +
            "#"*100)

    print("\n\nLet's explore some US bikeshare data!\n")
    print("Type\033[0;31;40m end\033[0;37;40m at any time if you would like to exit the program.\n")

    while True:

        city = choice(input("\nFor what city(ies) do you want do select data, New York City, Chicago or Washington? If more than one city, separate with commas.\n>"), CITY_DATA.keys())
        month = choice(input("\nFrom January to June, for what month(s) do you want do select data?\n>"), months)
        day = choice(input("\nFor what day(s) of the week do you want do obtain bikeshare data?\n>"), weekdays)

        # confirm the user input
        confirmation = choice(input(f"\nPlease confirm that you would like to apply the following filter(s) to the bikeshare data.\n\n City(ies): {city}\n Month(s): {month}\n Weekdays: {day}\n\n [y] Yes\n [n] No\n\n>"))
        if confirmation == 'y':
            break
        else:
            print("Let's try this again")

    print('-'*40)
    return city, month, day


def load_data(city, month, day):
    """
    Loads data for the specified city and filters by month and day if applicable.

    Args:
        (str) city - name of the city to analyze
        (str) month - name of the month to filter by, or "all" to apply no month filter
        (str) day - name of the day of week to filter by, or "all" to apply no day filter
    Returns:
        df - Pandas DataFrame containing city data filtered by month and day
    """

    start_time = time.time()

    if isinstance(city, list):
        df = pd.concat(map(lambda city : pd.read_csv(CITY_DATA[city]), city))
    else:
        df = pd.read_csv(CITY_DATA[city])

    df['Start Time'] = pd.to_datetime(df['Start Time'])
    df['Month'] = df['Start Time'].dt.month
    df['Weekday'] = df['Start Time'].dt.weekday_name
    df['Start Hour'] = df['Start Time'].dt.hour
    
    if isinstance(month, list):

        # filter the data according to month and weekday into two new DataFrames   
        df = pd.concat(map(lambda month : df[df['Month'] == (months.index(month)+1)], month))
        df = pd.concat(map(lambda y : df[df['Weekday'] == (y.title())], day))

    else:
        df = df[df['Month'] == (months.index(month)+1)]
        df = df[df['Weekday'] == day.title()]

    print("\nThe program just loaded the data for the filters of your choice.")
    print("\nThis took {} seconds.".format((time.time() - start_time)))

    return df


def time_stats(df):
    """Displays statistics on the most frequent times of travel."""

    print('\nDisplaying the statistics on the most frequent times of travel...\n')
    start_time = time.time()

    # display the most common month
    most_common_month = df['Month'].mode()[0]
    print('For the selected filter, the month with the most travels is: ' + str(months[most_common_month-1]).title() + '.')

    # display the most common day of week
    most_common_day = df['Weekday'].mode()[0]
    print('For the selected filter, the most common day of the week is: ' + str(most_common_day) + '.')
    
    # display the most common start hour
    most_common_hour = df['Start Hour'].mode()[0]
    print('For the selected filter, the most common start hour is: ' + str(most_common_hour) + '.')

    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*40)


def station_stats(df):
    """Displays statistics on the most popular stations and trip."""

    print('\nCalculating The Most Popular Stations and Trip...\n')
    start_time = time.time()

    # display most commonly used start station
    most_common_start_station = str(df['Start Station'].mode()[0])
    print("For the selected filters, the most common start station is: " + most_common_start_station)

    # display most commonly used end station
    most_common_end_station = str(df['End Station'].mode()[0])
    print("For the selected filters, the most common start end is: " + most_common_end_station)

    # display most frequent combination of start station and end station trip
    df['Start-End Combination'] = df['Start Station'] + ' - ' + df['End Station']
    most_common_start_end_combination = str(df['Start-End Combination'].mode()[0])
    print("For the selected filters, the most common start-end combination of stations is: " + most_common_start_end_combination)

    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*40)


def trip_duration_stats(df):
    """Displays statistics on the total and average trip duration."""

    print('\nCalculating Trip Duration...\n')
    start_time = time.time()

    # display total travel time
    total_travel_time = df['Trip Duration'].sum()

    total_travel_time = (   str(int(total_travel_time//86400)) + 'd ' +
                            str(int((total_travel_time%86400)//3600)) + 'h ' + 
                            str(int(((total_travel_time%86400)%3600)//60)) + 'm ' +
                            str(int(((total_travel_time%86400)%3600)%60)) + 's')

    print('For the selected filters, the total travel time is : ' + total_travel_time + '.')

    # display mean travel time
    mean_travel_time = df['Trip Duration'].mean()
    mean_travel_time = (    str(int(mean_travel_time//60)) + 'm ' +
                            str(int(mean_travel_time%60)) + 's')
    print("For the selected filters, the mean travel time is : " + mean_travel_time + ".")

    print("\nThis took {} seconds.".format((time.time() - start_time)))
    print('-'*40)


def user_stats(df, city):
    """Displays statistics on bikeshare users."""

    print('\nCalculating User Stats...\n')
    start_time = time.time()

    # Display counts of user types
    user_types = df['User Type'].value_counts().to_string()
    print("Distribution for user types:")
    print(user_types)

    # Display counts of gender
    try:
        gender_distribution = df['Gender'].value_counts().to_string()
        print("\nDistribution for each gender:")
        print(gender_distribution)
    except KeyError:
        print("We're sorry! There is no data of user genders for {}.".format(city.title()))

    # Display earliest, most recent, and most common year of birth
    try:
        earliest_birth_year = str(int(df['Birth Year'].min()))
        print("\nFor the selected filter, the oldest person to ride one bike was born in: " + earliest_birth_year)
        
        most_recent_birth_year = str(int(df['Birth Year'].max()))
        print("For the selected filter, the youngest person to ride one bike was born in: " + most_recent_birth_year)
        
        most_common_birth_year = str(int(df['Birth Year'].mode()))
        print("For the selected filter, the most common birth year amongst riders is: " + most_common_birth_year)

    except:
        print("We're sorry! There is no data of birth year for {}.".format(city.title()))



    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*40)


def main():
    while True:
        click.clear()
        city, month, day = get_filters()
        df = load_data(city, month, day)

        while True:
            select_data = choice(input("\nPlease select the information you would like to obtain.\n [ts] Time Stats\n [ss] Station Stats\n [tds] Trip Duration Stats\n [us] User Stats\n [r] Restart\n\n>"), ('ts', 'ss', 'tds', 'us', 'r'))
            click.clear()
            if select_data == 'ts':
                time_stats(df)
            if select_data == 'ss':
                station_stats(df)
            if select_data == 'tds':
                trip_duration_stats(df)
            if select_data == 'us':
                user_stats(df, city)
            if select_data == 'r':
                break

        restart = input('\nWould you like to restart? Enter yes or no.\n')
        if restart.lower() != 'yes':
            break


if __name__ == "__main__":
	main()
